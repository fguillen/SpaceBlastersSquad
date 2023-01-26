extends Control

onready var label_points:Label = $"%LabelPoints"
onready var shields_display := $"%ShieldsDisplay"

func _ready():
	Global.connect("points_changed", self, "on_points_changed")
	Global.connect("points_changed", self, "on_points_changed")

func on_points_changed(value):
	label_points.set_points(value)
