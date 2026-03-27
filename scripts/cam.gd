extends Camera2D
const OFFSET = Vector2(200, -100)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_node("/root/main/car/car").position + OFFSET
