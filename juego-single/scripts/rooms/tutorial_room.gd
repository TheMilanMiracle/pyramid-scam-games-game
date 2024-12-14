extends Room


@onready var bars: TileMapLayer = $Bars
@onready var bottom_bars: TileMapLayer = $BottomBars
@onready var goal: CollisionShape2D = $Area2D/Goal
@onready var post_enemy_1: ShootingEnemy = $PostEnemy1

@onready var force: RichTextLabel = $Force
@onready var slow_area: RichTextLabel = $SlowArea

func _ready() -> void:
	enemy_count = 1

func updateRoomState() -> void:
	if enemy_count == 0:
		bars.queue_free()
		bottom_bars.queue_free()
		
		post_enemy_1.process_mode = Node.PROCESS_MODE_INHERIT
		
		post_enemy_1.show()
		
		force.hide()
		slow_area.show()
