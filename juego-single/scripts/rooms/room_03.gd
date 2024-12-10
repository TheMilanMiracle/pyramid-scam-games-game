extends room

@onready var tile_map_layer_2: TileMapLayer = $TileMapLayer2
@onready var tile_map_layer_3: TileMapLayer = $TileMapLayer3

func _ready() -> void:
	enemy_count = 7

func updateRoomState() -> void:
	if enemy_count == 4:
		tile_map_layer_2.queue_free()
	elif enemy_count == 0:
		tile_map_layer_3.queue_free()
