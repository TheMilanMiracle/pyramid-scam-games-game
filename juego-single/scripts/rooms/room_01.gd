extends Room

@onready var tile_map_layer_2: TileMapLayer = $TileMapLayer2
@onready var tile_map_layer_3: TileMapLayer = $TileMapLayer3

func _ready() -> void:
	enemy_count = 2

func updateRoomState() -> void:
	pass
