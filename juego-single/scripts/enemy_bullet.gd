extends Area2D

var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func take_damage_en():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += speed * transform.y * delta

func _on_body_entered(body: Node2D):
	if body.has_method("take_damage"):
		body.take_damage()
		queue_free()

func _on_area_entered(body: Area2D):
	if body.has_method("take_damage"):
		body.take_damage()
		queue_free()
	if body.has_method("defense"):
		queue_free()
