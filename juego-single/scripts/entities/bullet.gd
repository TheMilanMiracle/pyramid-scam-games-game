class_name Bullet
extends Area2D

signal bullet_died()

const speed: int = 800

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func take_damage_en():
	queue_free()

func _physics_process(delta: float) -> void:
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
