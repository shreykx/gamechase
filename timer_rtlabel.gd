extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 10
	bbcode_enabled = true
	text = "[b]TIMER: 60[/b]	"
	pass # Replace with function body.

func update_timer_display(time_in_seconds: float, text_color: Color) -> void:
	var seconds_display: int = ceil(time_in_seconds)
	var hex_color: String = text_color.to_html(false)
	text = "[b][color=#" + hex_color + "]TIMER: " + str(seconds_display) + "[/color][/b]"
	pass
