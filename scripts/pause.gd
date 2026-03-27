extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = 99999
	process_mode = Node.PROCESS_MODE_ALWAYS
	$ColorRect.process_mode = Node.PROCESS_MODE_ALWAYS
	$title.process_mode = Node.PROCESS_MODE_ALWAYS
	$continue.process_mode = Node.PROCESS_MODE_ALWAYS
	$menu.process_mode = Node.PROCESS_MODE_ALWAYS
	
	$ColorRect.modulate.a = 0.0  # Start fully transparent
	$title.modulate.a = 0.0  # Start fully transparent
	$continue.modulate.a = 0.0  # Start fully transparent
	$menu.modulate.a = 0.0  # Start fully transparent

var paused

func unpause():
	get_node("/root/main/overlay").show()
	
	get_tree().paused = false
	paused = false
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property($ColorRect, "modulate:a", 0.0, 0.2).from(0.6)
	tween.tween_property($title, "modulate:a", 0.0, 0.2).from(1.0)
	tween.tween_property($continue, "modulate:a", 0.0, 0.2).from(1.0)
	tween.tween_property($menu, "modulate:a", 0.0, 0.2).from(1.0)
	await tween.finished
	position.y = 99999

func pause():
	get_node("/root/main/overlay").hide()
	
	position.y = 0
	get_tree().paused = true
	paused = true
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property($ColorRect, "modulate:a", 0.6, 0.2).from(0.0)
	tween.tween_property($title, "modulate:a", 1.0, 0.2).from(0.0)
	tween.tween_property($continue, "modulate:a", 1.0, 0.2).from(0.0)
	tween.tween_property($menu, "modulate:a", 1.0, 0.2).from(0.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if paused:
		if Input.is_action_just_pressed("pause"):
			unpause()
		
	else:
		if Input.is_action_just_pressed("pause"):
			pause()


func _on_continue_pressed() -> void:
	if paused:
		$click.play()
		unpause()


func _on_menu_pressed() -> void:
	if paused:
		unpause()
		$click.play()
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_restart_pressed() -> void:
	if paused:
		unpause()
		$click.play()
		get_tree().reload_current_scene()
