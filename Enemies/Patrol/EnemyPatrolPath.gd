class_name EnemyPatrolPath
extends EnemyBase

export var path_path := NodePath()
var path: Path2D

var node_to_follow


func setup():
	path = get_node(path_path)
	node_to_follow = path.attach_enemy(self)

	.setup()


func on_activate():
	pass



func _notification(what):
	if (what == NOTIFICATION_PREDELETE):
		# print("EnemyPatrolPath.before free: ", path)
		if(is_instance_valid(path)):
			path.remove_enemy(self)
