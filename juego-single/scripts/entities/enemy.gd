extends RigidBody2D

var selected = false
var mouse_position = Vector2(0, 0)
var mouse_offset = Vector2(0, 0)
var new_pos = Vector2(0, 0)
var impulse_direction = Vector2.ZERO

const MAX_HEALTH: int = 3
var HEALTH: int

const bullet = preload("res://scenes/entities/bullet.tscn")
@onready var left_marker: Marker2D = $Path2D/LPath/LMarker
@onready var left_direction: Marker2D = $Path2D/LPath/LMarker/LEnemyDirection
@onready var right_marker: Marker2D = $Path2D/RPath/RMarker
@onready var right_direction: Marker2D = $Path2D/RPath/RMarker/REnemyDirection
@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var sprite: Sprite2D = $Sprite
@onready var hurtbox = $Hurtbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var on_damage_timer: Timer = $OnDamageTimer

var default_color: Color
var damage_color: Color = Color(0.8, 0.2, 0.4, 1.)

func _ready() -> void:
	default_color = modulate
	
	animation_player.play("idle")
	HEALTH = MAX_HEALTH
	shoot_cooldown.timeout.connect(shoot)
	
	on_damage_timer.timeout.connect(func(): sprite.modulate = default_color)


func _physics_process(delta: float) -> void:
	if selected and Input.is_action_pressed("force"):  # Apply impulse when holding a key
		print("force")
		apply_my_impulse()

func take_damage(damage: int) -> void:
	on_damage_timer.start()
	sprite.modulate = damage_color
	
	HEALTH -= damage

	if HEALTH == 0:
		get_parent().enemyDead()
		queue_free()

func shoot():
	var left_bullet: Bullet = bullet.instantiate()
	var right_bullet: Bullet = bullet.instantiate()
	
	get_parent().add_child(left_bullet)
	get_parent().add_child(right_bullet)
	
	left_bullet.global_position = left_marker.global_position
	right_bullet.global_position = right_marker.global_position
	
	left_bullet.look_at(left_direction.global_position)
	right_bullet.look_at(right_direction.global_position)
	
	left_bullet.SPEED_MULTIPLIER = 0.8
	right_bullet.SPEED_MULTIPLIER = 0.8
	
	left_bullet.modulate = Color(0.5, 0.1, 0.1)
	right_bullet.modulate = Color(0.5, 0.1, 0.1)


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
