extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D/start.position.y = 0
	$Camera2D/select.position.y = 9999
		
	var tween = create_tween()
	tween.tween_property($Camera2D/start/fade, "modulate:a", 0.0, 1.0).from(1.0)
	await tween.finished
	$Camera2D/start/fade.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Camera2D.position = get_viewport().get_mouse_position() / 5
	
	var amplitude = 15
	var frequency = 2.0
	var offset = -300

	$Camera2D/start/title.position.y = offset + amplitude * sin(frequency * Time.get_ticks_msec() / 1000.0)

func _on_button_pressed() -> void:
	Global.highscore = 0
	Global.seed = 12350
	Global.world_color = Color8(0, 129, 0)
	Global.noise_scale = 0.06
	Global.initial_amplitude = 0.5
	Global.amplitude_scaling = 0.0005
	Global.verticle_scaling = 0
	Global.gravity = 1
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_info_pressed() -> void:
	if not $Camera2D/start/info2.is_open:
		$click.play()
		$Camera2D/start/info2.open()


func _on_options_pressed() -> void:
	if not $Camera2D/start/info2.is_open:
		$click.play()
		$Camera2D/start.position.y = 9999
		$Camera2D/select.position.y = 0
