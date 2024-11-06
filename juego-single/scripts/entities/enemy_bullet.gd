class_name EnemyBullet
extends Area2D

signal bullet_died()

const speed:int = 300

var default_delta_multiplier: float = 1.
var delta_multiplier: float = 1.

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func take_damage_en():
	queue_free()


func _physics_process(delta: float) -> void:
	delta *= delta_multiplier
	
	position += speed * transform.y * delta


func _on_body_entered(body: Node2D):
	if body.has_method("take_damage"):
		body.take_damage()
		queue_free()
	if body.has_method("take_damage_en"):
		body.take_damage_en()
		queue_free()
	
	bullet_died.emit()


func _on_area_entered(body: Area2D):
	if body.has_method("take_damage"):
		body.take_damage()
		queue_free()
	
	if body.has_method("defense"):
		queue_free()
	
	bullet_died.emit()


func slow_down(multiplier: float) -> void:
	delta_multiplier = multiplier


func speed_up() -> void:
	delta_multiplier = default_delta_multiplier
