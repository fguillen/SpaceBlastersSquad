class_name ShieldDisplay
extends Control

export (Resource) var shield_template

export (int) var ini_num_shields := 3
export (int) var ini_num_shields_full := 3

var num_shields setget set_num_shields
var num_shields_full setget set_num_shields_full

onready var shields_control := $Shields


func _ready():
	set_num_shields(ini_num_shields)
	num_shields_full = ini_num_shields
	set_num_shields_full(ini_num_shields_full)


func set_num_shields(value):
	remove_all_shields()
	for i in value:
		add_shield()


func set_num_shields_full(value):
	if value > num_shields_full:
		add_shield_full()
		set_num_shields_full(value)
	elif value < num_shields_full:
		remove_shield_full()
		set_num_shields_full(value)


func add_shield_full():
	print("add_shield_full")

	if num_shields_full == num_shields:
		print("All shields already full but trying to full another one")
		return

	num_shields_full += 1

	print("num_shields_full: ", num_shields_full, " ,", num_shields)
	shields_control.get_child(num_shields_full - 1).full = true


func remove_shield_full():
	print("remove_shield_full")

	if num_shields_full == 0:
		print("All shields already empty but trying to empty another one")
		return

	num_shields_full -= 1
	print("num_shields_full: ", num_shields_full)
	shields_control.get_child(num_shields_full).full = false


func remove_all_shields():
	num_shields = 0
	for child in shields_control.get_children():
		child.queue_free()


func add_shield():
	num_shields += 1
	var shield = shield_template.instance()
	shields_control.add_child(shield)


func _on_ButtonAdd_pressed():
	add_shield_full()


func _on_ButtonRemove_pressed():
	remove_shield_full()


func _on_RemoveShieldFull_pressed():
	pass # Replace with function body.
