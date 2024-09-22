extends Area2D

@onready var slow_area_sprite: Sprite2D = $SlowAreaSprite
@onready var slow_area_shape: CollisionShape2D = $SlowAreaShape
@onready var action_timer: Timer = $"ActionTimer"

func _ready() -> void:
	action_timer.timeout.connect(_on_action_timer_timeout)
	
	slow_area_shape.disabled = true
	slow_area_sprite.visible = false


func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				position = get_viewport().get_camera_2d().get_global_mouse_position()
				slow_area_shape.disabled = false
				slow_area_sprite.visible = true
				action_timer.start()


func _on_action_timer_timeout() -> void:
	slow_area_shape.disabled = true
	slow_area_sprite.visible = false
