extends Node2D
class_name TerrainGenerator

# Configuration
@export var chunk_width: int = 1000  # Width of each terrain chunk in pixels
@export var amplitude: float = 150.0  # Height of hills
var vertical_offset = 0
@export var load_distance: int = 3  # Number of chunks to load on each side
@export var outline_color: Color
var base_color = Global.world_color

# References
var car: Node2D
var noise: FastNoiseLite
var active_chunks = {}  # Dictionary to store currently loaded chunks

var initial_amplitude = Global.initial_amplitude
var amplitude_scaling = Global.amplitude_scaling
var verticle_scaling = Global.verticle_scaling

func _ready():
	# Initialize noise generator
	noise = FastNoiseLite.new()
	noise.seed = int(Global.seed)  # Random seed for terrain generation
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = Global.noise_scale
	
	# Get reference to the car
	car = get_node("/root/main/car/car")
	
	# Initial chunk loading
	update_chunks()

func _process(_delta):
	update_chunks()

func update_chunks():
	if !car:
		push_error("Car node not found at /root/main/car")
		return
	
	var car_pos = car.global_position
	var current_chunk_x = floor(car_pos.x / chunk_width)
	
	# Determine which chunks should be active
	var should_be_active = {}
	for i in range(-load_distance, load_distance + 1):
		var chunk_id = current_chunk_x + i
		
		should_be_active[chunk_id] = true
		
		# Load chunk if it doesn't exist
		if not active_chunks.has(chunk_id):
			load_chunk(chunk_id)
	
	# Unload chunks that are too far away
	var chunks_to_remove = []
	for chunk_id in active_chunks.keys():
		if not should_be_active.has(chunk_id):
			chunks_to_remove.append(chunk_id)
	
	for chunk_id in chunks_to_remove:
		unload_chunk(chunk_id)

func load_chunk(chunk_id):

	var chunk = TerrainChunk.new()
	chunk.setup(chunk_id, chunk_width, noise, amplitude, vertical_offset, base_color, outline_color, initial_amplitude, amplitude_scaling, verticle_scaling)
	add_child(chunk)
	active_chunks[chunk_id] = chunk

func unload_chunk(chunk_id):

	if active_chunks.has(chunk_id):
		active_chunks[chunk_id].queue_free()
		active_chunks.erase(chunk_id)

# Get height at any x position in the world (useful for car placement)

# TerrainChunk class - handles the creation of each chunk of terrain
class TerrainChunk extends StaticBody2D:
	var chunk_id: int
	var chunk_width: int
	var points = []
	var base_color: Color
	var outline_color: Color
	
	

	func setup(id, width, noise, amplitude, vertical_offset, base_color: Color, outline_color: Color, initial_amplitude, amplitude_scaling, verticle_scaling):
		chunk_id = id
		chunk_width = width
		self.base_color = base_color
		self.outline_color = outline_color
		position.x = id * width
		
		# Generate terrain points using noise
		var resolution = 20  # Distance between points
		var num_points = width / resolution + 1
		points = []
		
		var checkpoint_scene = preload("res://scenes/checkpoint.tscn")
		
		# Generate points based on Perlin noise
		for i in range(num_points):
			var x = i * resolution
			var sample_x = (id * width + x) * 0.01  # Consistent sampling across chunks
			var point_id = (chunk_id * 50) + i

			var height = noise.get_noise_1d(sample_x) * (amplitude * ((point_id * amplitude_scaling) + initial_amplitude)) + (point_id * -verticle_scaling) + vertical_offset
			points.append(Vector2(x, height))
			
			
		
		# Draw terrain
		draw_terrain(resolution)
		
		# Add collision
		create_collision()
	
	func draw_terrain(resolution):
		var polygon = points.duplicate()
		
		# Add bottom corners to complete the polygon
		polygon.append(Vector2(chunk_width, 1000))
		polygon.append(Vector2(0, 1000))
		
		# Draw the terrain polygon
		var terrain = Polygon2D.new()
		terrain.polygon = polygon
		terrain.color = base_color
		add_child(terrain)

		
		var line = Line2D.new()
		line.points = points
		line.width = 10
		line.default_color = outline_color
		add_child(line)



		
	
	func create_collision():
		var collision = CollisionPolygon2D.new()
		
		# Create collision shape extending down
		var collision_points = points.duplicate()
		collision_points.append(Vector2(chunk_width, 1000))
		collision_points.append(Vector2(0, 1000))
		
		collision.polygon = collision_points
		add_child(collision)
