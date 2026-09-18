extends Node2D

@onready var other_obj = get_node("../Player")

func _process(delta: float) -> void:
	
	global_position = other_obj.global_position
	global_position.x = (other_obj.global_position.x + 0)/6 + other_obj.global_position.x


func _on_player_radiator_touched() -> void:
	pass # Replace with function body.
