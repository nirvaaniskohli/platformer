extends Node2D

@export var player: CharacterBody2D

func _ready():
	hide()

	player.radiator_touched.connect(_on_radiator_touched)
	

func _on_radiator_touched(count):
	print("ISHOWED")
	show()


func _on_player_radiator_touched() -> void:
	print("ISHOWED")
	show()
