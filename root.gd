extends Node2D

var Character = preload("res://character_body_2d.tscn")
var instance : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instance = Character.instantiate()
	instance.position = $Marker2D.position
	add_child(instance)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
