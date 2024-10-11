extends RigidBody2D

var selected = false
var mouse_position = Vector2(0, 0)
var mouse_offset = Vector2(0, 0)
var new_pos = Vector2(0, 0)
var impulse_direction = Vector2.ZERO

const bulletPath = preload("res://scenes/enemy_bullet.tscn")
@onready var marker_2d: Marker2D = $Path2D/PathFollow2D/Marker2D
@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var marker_2d_2: Marker2D = $Path2D/PathFollow2D2/Marker2D
@onready var hurtbox = $Hurtbox


func _ready() -> void:
	shoot_cooldown.timeout.connect(shoot)
	
func _physics_process(delta: float) -> void:
	if selected and Input.is_action_pressed("force"):  # Apply impulse when holding a key
		print("force")
		apply_my_impulse()

func take_damage_en():
	queue_free()

func shoot():
	var bullet = bulletPath.instantiate()
	var bullet_2 = bulletPath.instantiate()
	add_child(bullet)
	add_child(bullet_2)
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
	impulse_direction = get_global_mouse_position() - position  # Calculate direction vector
	apply_central_impulse(impulse_direction * 4)  # Apply a scaled impulse
	selected = false  # Unselect after applying impulse
