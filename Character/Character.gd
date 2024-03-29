class_name Character
extends KinematicBody2D

export (int) var ini_max_health := 3
export (int) var speed := 50 setget set_speed
export (int) var damage_on_collision := 100

export var state_manager_path := NodePath()
export var input_manager_path := NodePath()
export var movement_manager_path := NodePath()
export var animation_player_path := NodePath()
export var weapon_manager_path := NodePath()
export var damage_manager_path := NodePath()

export (Resource) var weapon_default = null


onready var input_manager: InputManager = get_node(input_manager_path)
onready var movement_manager: MovementManager = get_node(movement_manager_path)
onready var animation_player: AnimationPlayer = get_node(animation_player_path)
onready var state_manager: StateManager = get_node(state_manager_path)
onready var weapon_manager: WeaponManager = get_node(weapon_manager_path)
onready var damage_manager: DamageManager = get_node(damage_manager_path)

signal health_changed(value)
signal out_of_health(position)
signal dead(position)
signal hit(position)

var looking_towards = Vector2.RIGHT


func _ready():
	damage_manager.max_health = ini_max_health
	damage_manager.health = ini_max_health
	damage_manager.connect("health_changed", self, "on_health_changed")
	damage_manager.connect("out_of_health", self, "on_out_of_health")

	state_manager.setup(self, "Idle")

	weapon_manager.setup(self)

	if(weapon_default != null):
		var weapon = weapon_default.instance()
		weapon_manager.add_weapon(weapon)

	movement_manager.MAX_SPEED = speed


func _unhandled_input(event: InputEvent) -> void:
	state_manager.handle_input(event)


func _process(delta: float) -> void:
	state_manager.process(delta)


func _physics_process(delta: float) -> void:
	state_manager.physics_process(delta)
	move_and_slide(movement_manager.velocity)
	var collision = get_last_slide_collision ( )
	if collision != null:
		_on_collision(collision)


func get_class():
	return "Character"


func get_hit(damage:int, position:Vector2):
	print("%s.get_hit()", name)
	damage_manager.get_hit(damage)
	emit_signal("hit", position)


func on_health_changed(value:int):
	emit_signal("health_changed", value)


func on_out_of_health():
	print("Out of health")
	emit_signal("out_of_health", global_position)
	state_manager.transition_to("Dead")


func on_animation_ended():
	state_manager.animation_ended()


func dead():
	print("dead")
	emit_signal("dead", global_position)
	queue_free()


func _on_collision(collision):
	state_manager.on_collision(collision)

	if collision.collider.has_method("get_hit"):
		collision.collider.get_hit(damage_on_collision, collision.position)


func set_speed(value):
	speed = value
	if movement_manager:
		movement_manager.MAX_SPEED = value
