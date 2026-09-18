extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -100.0
const WALL_JUMP_PUSH = 120.0
@onready var tile_map: TileMapLayer = $"../TileMapLayer"
signal radiator_touched()
var radiator_count = 0
var last_radiator_cell = Vector2i(-999, -999)

@export var fall_threshold: float = 12000.0


func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta * 0.25

	var direction := Input.get_axis("left", "right")
	if direction:
		
		velocity.x = move_toward(velocity.x, direction * SPEED, SPEED/10)
		
	else:
		
		velocity.x = move_toward(velocity.x, 0, SPEED/20)

	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY

		elif is_on_wall():
			var wall_normal = get_wall_normal()

			velocity.y = JUMP_VELOCITY
			velocity.x = wall_normal.x * WALL_JUMP_PUSH

	if global_position.y > fall_threshold:
		restart_game()

	move_and_slide()
	check_radiator()
	



func check_radiator():
	
	var local_pos = tile_map.to_local(global_position)
	var cell = tile_map.local_to_map(local_pos)

	var tile_data = tile_map.get_cell_tile_data(cell)

	if tile_data == null:
		return

	var tile_type = tile_data.get_custom_data("tile_type")

	if tile_type == "Radiator":
		

		if cell != last_radiator_cell:
			
			radiator_count += 1


			last_radiator_cell = cell



			
			if radiator_count > 4:


				radiator_touched.emit()


func restart_game() -> void:
	get_tree().reload_current_scene()
