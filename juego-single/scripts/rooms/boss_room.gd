extends Room
@onready var player: Player = $Player

func _ready() -> void:
	enemy_count = 1

func updateRoomState() -> void:
	if enemy_count == 0:
		player.victory_menu.show()
		get_tree().paused = true
