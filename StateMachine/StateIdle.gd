class_name StateIdle
extends State


func enter(_msg := {}) -> void:
	character.animation_player.play("Idle")

func process(_delta: float) -> void:
	character.movement_manager.direction = character.input_manager.get_move_direction()

	if character.movement_manager.direction != Vector2.ZERO:
		character.state_machine.transition_to("Move")
		return

	character.movement_manager.apply_friction()
	character.movement_manager.velocity = character.move_and_slide(character.movement_manager.velocity)
