extends Node2D

const ACCELLERATION = 150
const SPEED = 150
const BREAK_MULTIPLIER = 3

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = -30
	$wheel1.gravity_scale = Global.gravity
	$wheel2.gravity_scale = Global.gravity
	$car.gravity_scale = Global.gravity
	$package1.gravity_scale = Global.gravity
	$package2.gravity_scale = Global.gravity
	$package3.gravity_scale = Global.gravity
	$car.add_to_group("car_body")
	add_to_group("car")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not dead:
		if Input.is_action_pressed("right"):
			$car/GPUParticles2D.emitting = true
			if $wheel1.angular_velocity < 0:
				$wheel1.angular_velocity += ACCELLERATION * delta * BREAK_MULTIPLIER
			else:
				$wheel1.angular_velocity += ACCELLERATION * delta
		else:
			$car/GPUParticles2D.emitting = false
		if Input.is_action_pressed("left"):
			if $wheel1.angular_velocity > 0:
				$wheel1.angular_velocity -= ACCELLERATION * delta * BREAK_MULTIPLIER
			else:
				$wheel1.angular_velocity -= ACCELLERATION * delta
	else:
		$car/GPUParticles2D.emitting = false
	$wheel1.angular_velocity = clamp($wheel1.angular_velocity, -SPEED, SPEED)
	
	# Exponential decay of velocity with delta
	var damping_strength = 5.0  # How quickly it slows down (higher = faster stop)
	$wheel1.angular_velocity *= exp(-damping_strength * delta)


	$wheel2.angular_velocity = $wheel1.angular_velocity
	
	
	
	

func die():
	print("DEAD")
	dead = true
	$die.play()
	$package1/PinJoint2D.queue_free()
	$package2/PinJoint2D.queue_free()
	$package3/PinJoint2D.queue_free()
	$package3/DampedSpringJoint2D.queue_free()
	get_node("/root/main/death/Control").die()







func _on_die_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TerrainGenerator.TerrainChunk:
		if not dead:
			die()
