extends RigidBody2D

var selected = false
var mouse_position = Vector2(0, 0)
var mouse_offset = Vector2(0, 0)
var new_pos = Vector2(0, 0)
var impulse_direction = Vector2.ZERO

const MAX_HEALTH: int = 3
var HEALTH: int

const bulletPath = preload("res://scenes/entities/enemy_bullet.tscn")
@onready var marker_2d: Marker2D = $Path2D/PathFollow2D/Marker2D
@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var marker_2d_2: Marker2D = $Path2D/PathFollow2D2/Marker2D
@onready var hurtbox = $Hurtbox


func _ready() -> void:
	HEALTH = MAX_HEALTH
	shoot_cooldown.timeout.connect(shoot)
	
func _physics_process(delta: float) -> void:
	if selected and Input.is_action_pressed("force"):  # Apply impulse when holding a key
		print("force")
		apply_my_impulse()

func take_damage_en():
	HEALTH -= 1
	print("ouch")
	if HEALTH == 0:
		get_parent().enemyDead()
		queue_free()

func shoot():
	var bullet = bulletPath.instantiate()
	var bullet_2 = bulletPath.instantiate()
	get_parent().add_child(bullet)
	get_parent().add_child(bullet_2)
	bullet.global_position = marker_2d.global_position
	bullet.global_rotation = marker_2d.global_rotation
	bullet_2.global_position = marker_2d_2.global_position
	bullet_2.global_rotation = marker_2d_2.global_rotation


func _on_hurtbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("select"):
		mouse_offset = position - get_global_mouse_position()
		selected = true
		print("selected")


func apply_my_impulse() -> void:
	print("toy en apply")
	impulse_direction = get_global_mouse_position() - position  # Calcula el vector de dirección

	var max_impulse = 1000

	if impulse_direction.length() > max_impulse:
		impulse_direction = impulse_direction.normalized() * max_impulse

	apply_central_impulse(impulse_direction)  # Aplica el impulso
	selected = false  # Deselecciona después de aplicar el impulso
