class_name room
extends Node

var enemy_count: int = 0

func enemyDead() -> void:
	enemy_count -= 1
	updateRoomState()

func updateRoomState() -> void:
	pass
