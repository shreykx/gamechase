extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 10
	bbcode_enabled = true
	text = "[b]SCORE: 0[/b]	"
	pass # Replace with function body.
