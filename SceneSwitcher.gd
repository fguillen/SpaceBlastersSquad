extends CanvasLayer

func load_game_over():
	change_scene("res://GUI/GameOver.tscn")

func load_start():
	change_scene("res://SpaceShooterScene.tscn")

func change_scene(target: String) -> void:
	$AnimationPlayer.play("FadeIn")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("FadeIn")