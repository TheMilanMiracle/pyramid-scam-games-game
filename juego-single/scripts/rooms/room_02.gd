extends Room

@onready var left_lever: Lever = $LeftLever
@onready var down_lever: Lever = $DownLever
@onready var right_lever: Lever = $RightLever
@onready var red_lights: TileMapLayer = $RedLights
@onready var bars: TileMapLayer = $Bars

var levers: int = 0

func _ready() -> void:
	left_lever.activated.connect(_on_left_activated)
	down_lever.activated.connect(_on_down_activated)
	right_lever.activated.connect(_on_right_activated)


func _on_left_activated() -> void:
	levers+=1
	_check_levers()
	for i in range(106, 109):
		for j in range(44, 48):
			red_lights.erase_cell(Vector2(i, j))


func _on_down_activated() -> void:
	levers+=1
	_check_levers()
	for i in range(121, 124):
		for j in range(44, 48):
			red_lights.erase_cell(Vector2(i, j))


func _on_right_activated() -> void:
	levers+=1
	_check_levers()
	for i in range(136, 139):
		for j in range(44, 48):
			red_lights.erase_cell(Vector2(i, j))


func _check_levers() -> void:
	if levers == 3:
		bars.queue_free()
