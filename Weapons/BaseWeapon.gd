class_name BaseWeapon
extends Node2D

onready var projectile_origin:Node2D = $ProjectileOrigin
onready var sprite:Sprite = $Sprite

export(float) var reload_time: = 1.0
export (Resource) var projectile_template = null

var reloading: = false
var reloading_timer: = Timer.new()
var character
var holder

signal attack(position, direction)


func weapon_name() -> String:
	return "Base"


func setup(character):
	add_child(reloading_timer)
	reloading_timer.set_one_shot(true)
	var _i = reloading_timer.connect("timeout", self, "_on_reloading_timer_timeout")

	self.character = character


func can_attack() -> bool:
	return not reloading


func attack(delay:float = 0) -> Array:
	reloading = true

	if delay > 0:
		yield(get_tree().create_timer(delay), "timeout")

	reloading_timer.start(reload_time)

	var projectile = projectile_template.instance()
	get_tree().current_scene.add_child(projectile)

	projectile.shoot(projectile_origin.global_position, projectile_direction())
	emit_signal("attack", projectile_origin.global_position, projectile_direction())

	return [projectile]


func projectile_direction() -> Vector2:
	if holder != null:
		return holder.direction()
	else:
		push_warning("Weapon.holder not found, direction RIGHT")
		return Vector2.RIGHT


func _on_reloading_timer_timeout():
	reloading = false


func get_texture() -> Texture:
	return sprite.texture
