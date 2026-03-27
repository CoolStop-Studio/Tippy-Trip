extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"select/seed/input".text = str(Global.seed)
	$"select/color/ColorPickerButton".color = Global.world_color
	$"select/initial hilliness/HSlider".value = Global.initial_amplitude
	$"select/hilliness scaling/HSlider".value = Global.amplitude_scaling
	$"select/slope/HSlider".value = Global.verticle_scaling
	$"select/jaggedness/HSlider".value = Global.noise_scale
	$"select/gravity/HSlider".value = Global.gravity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"select/initial hilliness/Label2".text = str($"select/initial hilliness/HSlider".value)
	$"select/hilliness scaling/Label2".text = str($"select/hilliness scaling/HSlider".value)
	$"select/slope/Label2".text = str($"select/slope/HSlider".value)
	$"select/jaggedness/Label2".text = str($"select/jaggedness/HSlider".value)
	$"select/gravity/Label2".text = str($"select/gravity/HSlider".value)







func _on_climb_pressed() -> void:
	$click.play()
	$"select/color/ColorPickerButton".color = Color8(107, 107, 107)
	$"select/initial hilliness/HSlider".value = 0.2
	$"select/hilliness scaling/HSlider".value = 0.001
	$"select/slope/HSlider".value = 4
	$"select/jaggedness/HSlider".value = 0.2
	$"select/gravity/HSlider".value = 0.8



func _on_hills_pressed() -> void:
	$click.play()
	$"select/color/ColorPickerButton".color = Color8(0, 143, 31)
	$"select/initial hilliness/HSlider".value = 0.4
	$"select/hilliness scaling/HSlider".value = 0.001
	$"select/slope/HSlider".value = 0
	$"select/jaggedness/HSlider".value = 0.1
	$"select/gravity/HSlider".value = 1

func _on_floaty_pressed() -> void:
	$click.play()
	$"select/color/ColorPickerButton".color = Color8(100, 100, 100)
	$"select/initial hilliness/HSlider".value = 1
	$"select/hilliness scaling/HSlider".value = 0.002
	$"select/slope/HSlider".value = 0
	$"select/jaggedness/HSlider".value = 0.01
	$"select/gravity/HSlider".value = 0.1





func _on_start_pressed() -> void:
	Global.highscore = 0
	Global.seed = $"select/seed/input".text
	Global.world_color = $"select/color/ColorPickerButton".color
	Global.noise_scale = $"select/jaggedness/HSlider".value
	Global.initial_amplitude = $"select/initial hilliness/HSlider".value
	Global.amplitude_scaling = $"select/hilliness scaling/HSlider".value
	Global.verticle_scaling = $"select/slope/HSlider".value
	Global.gravity = $"select/gravity/HSlider".value
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_texture_button_pressed() -> void:
	$click.play()
	$"select/seed/input".text = str(randi_range(1000000, 9999999))


func _on_close_pressed() -> void:
	$click.play()
	
	get_node("/root/menu/Camera2D/start").position.y = 0
	get_node("/root/menu/Camera2D/select").position.y = 9999
