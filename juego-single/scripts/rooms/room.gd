class_name room
extends Node

var enemy_count: int = 0

func enemyDead() -> void:
	enemy_count -= 1
	if enemy_count == 0:
		updateRoomState()

func updateRoomState() -> void:
	pass
