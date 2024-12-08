extends room


@onready var tile_map_layer_3: TileMapLayer = $TileMapLayer3
@onready var tile_map_layer_4: TileMapLayer = $TileMapLayer4
@onready var goal: CollisionShape2D = $Area2D/Goal

func _ready() -> void:
	enemy_count = 2

func updateRoomState() -> void:
	tile_map_layer_3.queue_free()
	tile_map_layer_4.queue_free()
