extends Panel

@onready var center = get_parent()

var tint: ColorRect
var game_over_text: Label
var play_again_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_minimum_size = Vector2(450, 300)
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	
	var canvas = center.get_parent() # grandparent relative to the white panel
	
	if canvas:
		print("grand_parent exists → tint code is running")
		print("grand_parent type: ", canvas.get_class())
		print("center index: ", center.get_index())
		
		# background black tint
		tint = ColorRect.new()
		tint.color = Color(0,0,0,0.4)
		tint.mouse_filter = Control.MOUSE_FILTER_STOP
		tint.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

		canvas.add_child.call_deferred(tint)
		tint.tree_entered.connect(func():
			canvas.move_child(tint, 0)
		, CONNECT_ONE_SHOT)
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color.WHITE
	add_theme_stylebox_override("panel", style)
	
	game_over_text = Label.new()
	game_over_text.text = "GAME OVER"
	game_over_text.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	game_over_text.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	game_over_text.add_theme_font_size_override("font_size", 36)
	game_over_text.add_theme_color_override("font_color", Color.BLACK)
	game_over_text.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(game_over_text)
	game_over_text.hide()
	
	play_again_button = Button.new()
	play_again_button.text = "PLAY AGAIN"
	play_again_button.custom_minimum_size = Vector2(180, 50)
	play_again_button.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	play_again_button.position = Vector2(-90, 65)
	play_again_button.pressed.connect(_on_play_again_pressed)

	add_child(play_again_button)
	play_again_button.hide()
	
	hide_end_panel()
	pass # Replace with function body.

func show_end_panel(final_score: int) -> void:
	center.show()
	tint.show()
	game_over_text.text = "GAME OVER\nSCORE: " + str(final_score)
	game_over_text.show()
	play_again_button.show()
	game_over_text.z_index = 10

func hide_end_panel() -> void:
	center.hide()
	tint.hide()
	game_over_text.hide()
	play_again_button.hide()

func _on_play_again_pressed() -> void:
	get_tree().reload_current_scene()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
