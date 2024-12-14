extends Node2D
class_name Lever

signal activated

@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var action_area: Area2D = $ActionArea
@onready var frame_timer: Timer = $FrameTimer


var player_near: bool = false
var frame: int = 0

func _ready() -> void:
	action_area.body_entered.connect(_on_body_entered)
	action_area.body_exited.connect(_on_body_exited)
	
	frame_timer.timeout.connect(_on_frame_timer_timeout)


func _input(event: InputEvent) -> void:
	if player_near:
		if event.is_action_released("use"):
			frame_timer.start()


func _on_body_entered(body: Node2D) -> void:
	body = body as Player
	
	if body:
		player_near = true


func _on_body_exited(body: Node2D) -> void:
	body = body as Player
	
	if body:
		player_near = false


func _on_frame_timer_timeout() -> void:
	frame += 1
	match frame:
		1:
			tile_map_layer.set_cell(Vector2i(0, -1), 2, Vector2i(1, 6), 0)
			tile_map_layer.set_cell(Vector2i(0, -2), 2, Vector2i(1, 5), 0)
			tile_map_layer.erase_cell(Vector2i(-1, -2))
			tile_map_layer.erase_cell(Vector2i(-1, -1))
			frame_timer.start()
		2:
			tile_map_layer.set_cell(Vector2i(0, -1), 2, Vector2i(2, 6), 0)
			tile_map_layer.set_cell(Vector2i(1, -1), 2, Vector2i(3, 6), 0)
			tile_map_layer.set_cell(Vector2i(1, -2), 2, Vector2i(3, 5), 0)
			tile_map_layer.erase_cell(Vector2i(-1, -2))
			tile_map_layer.erase_cell(Vector2i(-1, -1))
			tile_map_layer.erase_cell(Vector2i(0, -2))
			
			action_area.disconnect("body_entered", _on_body_entered)
			action_area.disconnect("body_exited", _on_body_exited)
			frame_timer.disconnect("timeout", _on_frame_timer_timeout)
			
			activated.emit()
