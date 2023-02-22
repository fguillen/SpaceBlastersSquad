class_name Utils
extends Node

static func get_parent_of_type(origin:Node, type:String) -> Node:
	var parent = origin.get_parent()
	print("parent: ", parent)
	if parent.get_class() == type:
		return parent
	elif parent == null:
		print("[WARNING] looking for parent type [%s], not found" % type)
		return null
	else:
		return get_parent_of_type(parent, type)
