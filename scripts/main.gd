extends Node2D

var score = 0
const marker_offset = 100
const px_per_m = 40
var is_highscore = true
const score_offset = Vector2(60, -150)
const volume = 0.3

var checkpoint_offset = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	if Global.highscore == 0:
		$highscore.queue_free()
		is_highscore = false
	else:
		$highscore.position.x = Global.highscore + marker_offset
		$highscore/Label.text = str(floor((Global.highscore  / px_per_m) * 10) / 10) + "m"
	score = 0


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("retry"):
		get_tree().reload_current_scene()
	
	if not $car.dead:
		$"car sound".pitch_scale = (abs($car/car.linear_velocity.x) / 200) + 0.5
		$"car sound".volume_linear = (abs(($car/car.linear_velocity.x) / 200) + 0.3) * volume
	else:
		$"car sound".volume_linear = 0
	score = $car/car.position.x
	$score.position = $car/car.position + score_offset + Vector2(checkpoint_offset, 0)
	$score/text.text = str(floor(((score + checkpoint_offset) / px_per_m) * 10) / 10) + "m"
	
	if is_highscore:
		
		$highscore/Parallax2D.scroll_offset.y -= 0.1
		# Convert top of the screen to world coordinates
		if get_viewport():
			var screen_top_left = Vector2(0, 0)
			var canvas_transform = get_viewport().get_canvas_transform()
			var world_top_left = canvas_transform.affine_inverse() * screen_top_left

		# Set the position of the highscore node
			$highscore.global_position.y = world_top_left.y + 30


func _on_pause_btn_pressed() -> void:
	$pause/Control.pause()


func _on_restart_btn_pressed() -> void:
	get_tree().reload_current_scene()
