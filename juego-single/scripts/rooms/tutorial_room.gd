extends Room


@onready var bars: TileMapLayer = $Bars
@onready var bottom_bars: TileMapLayer = $BottomBars
@onready var goal: CollisionShape2D = $Area2D/Goal

func _ready() -> void:
	enemy_count = 2

func updateRoomState() -> void:
	if enemy_count == 0:
		bars.queue_free()
		bottom_bars.queue_free()
