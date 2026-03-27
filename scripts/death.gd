extends Control

func _ready() -> void:
	$ColorRect.modulate.a = 0.0  # Start fully transparent
	$title.modulate.a = 0.0  # Start fully transparent
	$score.modulate.a = 0.0  # Start fully transparent
	$again.modulate.a = 0.0  # Start fully transparent
	$menu.modulate.a = 0.0  # Start fully transparent
	$best.modulate.a = 0.0  # Start fully transparent

func die():
	get_node("/root/main/overlay").hide()
	$music.stream_paused = true
	var score = get_node("/root/main").score
	var px_per_m = get_node("/root/main").px_per_m
	$score.text = str(floor((score  / px_per_m) * 10) / 10) + "m"
	if score > Global.highscore:
		Global.highscore = score
	else:
		$best.queue_free()
	
	
	
	
	
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property($ColorRect, "modulate:a", 0.8, 0.6).from(0.0)
	tween.tween_property(get_node("/root/main/score"), "modulate:a", 0.0, 0.6).from(1.0)
	tween.tween_property($title, "modulate:a", 1.0, 0.6).from(0.0)
	await tween.finished
	var tween2 = create_tween()
	tween2.tween_property($score, "modulate:a", 1.0, 0.6).from(0.0)
	tween2.tween_property($again, "modulate:a", 1.0, 0.5).from(0.0)
	tween2.tween_property($menu, "modulate:a", 1.0, 1.0).from(0.0)
	if $best:
		tween2.tween_property($best, "modulate:a", 1.0, 0.2).from(0.0)


func _on_menu_pressed() -> void:
	$click.play()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")



func _on_again_pressed() -> void:
	$click.play()
	get_tree().reload_current_scene()
