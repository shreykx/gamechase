extends Node

@onready var start_btn : Button = $Button
@onready var timer_label: RichTextLabel = $RichTextLabelTimer
@onready var score_label: RichTextLabel = $RichTextLabelScore
@onready var player: CharacterBody2D = $Area2D/Player
@onready var berry: Area2D = $Berry
@onready var panel: Panel = $CanvasLayer/CenterContainer/Panel

var is_game_running : bool = false
var game_time: float = 0.0
var max_game_duration: float = 10.0 # one round of 60 secs
var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_btn.pressed.connect(_on_start_button_press)
	print("Local: ", berry.position)
	print("Global: ", berry.global_position)
	berry.body_entered.connect(_on_berry_collected)
	pass # Replace with function body.

func _on_start_button_press() -> void:
	start_game()

# Game loops

func start_game() -> void:
	is_game_running = true
	player.activate_player()
	start_btn.hide()
	spawn_berry()
	pass

func end_game() -> void:
	is_game_running = false
	player.deactivate_player()
	panel.show_end_panel(score)
	pass

# function to handle player's collision with the collisionbody2ds and transfer them to the other side for continuity
func pass_player() -> void:
	var viewport_rect = get_viewport().get_visible_rect()
	var inverse_transform = get_viewport().get_canvas_transform().affine_inverse()
	var top_left = inverse_transform * viewport_rect.position
	var bottom_right = inverse_transform * viewport_rect.end

	var pos = player.global_position

	if pos.x > bottom_right.x:
		pos.x = top_left.x
	elif pos.x < top_left.x:
		pos.x = bottom_right.x

	if pos.y > bottom_right.y:
		pos.y = top_left.y
	elif pos.y < top_left.y:
		pos.y = bottom_right.y

	player.global_position = pos

func spawn_berry() -> void:
	var min_x = -281.0
	var max_x = 188.0
	var min_y = 192.0
	var max_y = -192.0
	var random_x = randf_range(min_x, max_x)
	var random_y = randf_range(min_y, max_y)
	berry.global_position = Vector2(random_x, random_y)
	pass

func _on_berry_collected(body: Node2D) -> void:
	print("Something touched the berry: ", body.name)
	if body == player and is_game_running:
		score += 1
		update_score_display()
		call_deferred("spawn_berry")


func update_score_display() -> void:
	score_label.text = "[b]SCORE: " + str(score)+"[/b]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_game_running:
		return
	game_time += delta
	var time_left: float = max_game_duration - game_time
	var current_color: Color = Color.RED if (time_left <= 5.0) else Color.WHITE
	timer_label.update_timer_display(time_left, current_color)
	pass_player()
	if game_time >= max_game_duration:
		end_game()
	pass
