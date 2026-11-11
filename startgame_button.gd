extends Button

func _ready() -> void:
	self_modulate = Color.WHITE
	z_index = 5
	set_stylebox_color("normal", Color("#EFBF04"))
	set_stylebox_color("hover", Color("#9E7E02"))
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	add_theme_font_size_override("font_size", 24)
	
	var system_font = SystemFont.new()
	system_font.font_weight = 700 # Tells the OS to use its bold variant
	add_theme_font_override("font", system_font)



func set_stylebox_color(style_box_type: String, color: Color) -> void:
		var stylebox_theme: StyleBoxFlat = get_theme_stylebox(style_box_type).duplicate()
		stylebox_theme.bg_color = color
		add_theme_stylebox_override(style_box_type, stylebox_theme)
		stylebox_theme.shadow_color = Color(0, 0, 0, 0.3)
		stylebox_theme.shadow_size = 4
		stylebox_theme.shadow_offset = Vector2(2, 2)
		add_theme_stylebox_override(style_box_type, stylebox_theme)
