extends Node

@onready var anim_sprite = $Node/Area2D/Player/AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_sprite.move_down()
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
