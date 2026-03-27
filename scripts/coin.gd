extends Node2D

var first_collision = true  # Flag to track if it's the first collision

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	# Only run the logic if this is not the first collision
	if first_collision:
		first_collision = false
		return
	print("Self: ", self.name, " - ID: ", self.get_instance_id(), " - Parent: ", self.get_parent().get_parent())


	# Increase score and queue free only after the first collision
	get_node("/root/main").score += 1
	queue_free()
