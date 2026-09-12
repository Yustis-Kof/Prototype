@abstract class_name EntityBody
extends Node2D
## Спрайт сущности

@onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")

@export var default_animation : String:
	set(value):
		default_animation = value
		#play(default_animation)
var animation_sequence : Array[String]



signal animation_ended
signal animation_sequence_ended

#func _init(_default_animation : String):
#	default_animation = _default_animation

func add_animation(animation : String) -> void:
	animation_sequence.append(animation)
	if animation_sequence.size() == 1:
		play(animation_sequence[0])

func skip() -> void:
	on_animation_ended(animation_sequence[0])
	#либо: animation_ended.emit(animation_sequence[-1])

func on_animation_ended(animation : String) -> void:
	animation_ended.emit(animation)
	animation_sequence.remove_at(0)
	if animation_sequence.size() <= 0:
		play(default_animation)
	else:
		play(animation_sequence[0])

func play(animation : String):
	animation_player.play(animation)

func _ready() -> void:
	animation_player.play(default_animation)
	animation_player.animation_finished.connect(on_animation_ended)
