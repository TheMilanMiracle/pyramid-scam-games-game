extends Area2D
class_name Bullet

signal bullet_died()


const SPEED: int = 800
var SPEED_MULTIPLIER: float = 1.
var DELTA_MULTIPLIER: float = 1.
var DAMAGE: int = 1


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	position += SPEED * SPEED_MULTIPLIER * DELTA_MULTIPLIER * transform.x * delta


func slow_down(multiplier: float) -> void:
	DELTA_MULTIPLIER = multiplier


func speed_up() -> void:
	DELTA_MULTIPLIER = 1.


func _on_body_entered(body: Node2D):
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE)
	
	queue_free()
	bullet_died.emit()


func _on_area_entered(body: Area2D):
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE)
		queue_free()
	
	bullet_died.emit()
