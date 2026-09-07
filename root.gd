extends Room



func _ready() -> void:
	var character = load("res://character_body_2d.tscn").instantiate()
	character.position = $Marker2D.position
	add_child(character)

	var smth = Hero.new()
	var sprite = character.rig.duplicate()
	#sprite.texture = preload("res://sprites/hero.png")
	smth.set_sprite(sprite, 0.38, Vector2(0, -114))
	spawn(smth, 0, 0)

	ui = $UI
	connect_ui()
