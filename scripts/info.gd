extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var is_open = false

func open():
	is_open = true
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5).from(0.0)

func close():
	is_open = false
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5).from(1.0)


func _on_texture_button_pressed() -> void:
	if is_open:
		$click.play()
		close()
