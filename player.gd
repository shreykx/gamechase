extends CharacterBody2D

@export var speed = 400
@onready var anim_sprite = $AnimatedSprite2D

func _ready() -> void:
	set_physics_process(false)

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction !=Vector2.ZERO:
		velocity = input_direction * speed
		update_animation(input_direction)

func update_animation(direction: Vector2) -> void:
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim_sprite.move_right()
		else:
			anim_sprite.move_left()
	else:
		if direction.y > 0:
			anim_sprite.move_down()
		else:
			anim_sprite.move_up()
func activate_player():
	set_physics_process(true)

func deactivate_player():
	set_physics_process(false)

func _physics_process(delta):
	get_input()
	move_and_slide()
	pass
