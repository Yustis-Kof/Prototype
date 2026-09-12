extends Room



func _ready() -> void:
	var character = load("res://character_body_2d.tscn").instantiate()
	character.position = $Marker2D.position
	add_child(character)

	var smth = Hero.new()
	var sprite = character.rig.duplicate()
	#sprite.texture = preload("res://sprites/hero.png")
	smth.set_sprite(sprite, 0.38, Vector2(0, -114))
	spawn(smth, 4, 4)

	ui = $Camera2D/UI
	connect_ui()
	connect_field()
	
	var test = StarPattern.new(0b00010101)
	print(test.directions)
