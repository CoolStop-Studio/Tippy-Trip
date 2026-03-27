extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("unlit")
	if position == Global.checkpoint:
		$AnimatedSprite2D.play("lit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("car_body"):
		print(position)
		
		if Global.checkpoint.x < position.x:
		
		
			$AnimatedSprite2D.play("lit")
			print("NEW CHECKPOINT: ", position.x)
			Global.checkpoint = position
			
