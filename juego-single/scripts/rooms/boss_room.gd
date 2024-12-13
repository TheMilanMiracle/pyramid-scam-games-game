extends Room
@onready var player: Player = $Player

func _ready() -> void:
	enemy_count = 1

func updateRoomState() -> void:
	if enemy_count == 0:
		player.victory_menu.show()
		await get_tree().create_timer(0.3).timeout
		get_tree().paused = true
