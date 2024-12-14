extends Room

@onready var door: TileMapLayer = $Door

func _ready() -> void:
	enemy_count = 4

func updateRoomState() -> void:
	if enemy_count == 0:
		door.queue_free()
