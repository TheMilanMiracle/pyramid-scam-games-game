extends RigidBody2D
class_name Enemy


@export var noIA: bool = false
@export var direction: = Vector2.ZERO

var selected = false
var mouse_position = Vector2(0, 0)
var mouse_offset = Vector2(0, 0)
var new_pos = Vector2(0, 0)
var impulse_direction = Vector2.ZERO

const MAX_HEALTH: int = 3
var HEALTH: int


@onready var sprite: Sprite2D = $Sprite
@onready var hurtbox = $Hurtbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree

@onready var on_damage_timer: Timer = $OnDamageTimer
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine

var default_color: Color
var damage_color: Color = Color(0.8, 0.2, 0.4, 1.)


func _ready() -> void:
	default_color = sprite.modulate
	
	animation_player.play("idle")
	HEALTH = MAX_HEALTH
	animation_tree.active = true
	
	on_damage_timer.timeout.connect(func(): sprite.modulate = default_color)
	
	enemy_state_machine.enemy = self
	if noIA:
		enemy_state_machine.queue_free()


func _physics_process(delta: float) -> void:
	update_animation_parameters()
	
	if selected and Input.is_action_pressed("force"):  # Apply impulse when holding a key
		apply_my_impulse()


func take_damage(damage: int) -> void:
	on_damage_timer.start()
	sprite.modulate = damage_color
	
	HEALTH -= damage
	
	if HEALTH == 0:
		get_parent().enemyDead()
		queue_free()


func _on_hurtbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("select"):
		mouse_offset = position - get_global_mouse_position()
		selected = true


func apply_my_impulse() -> void:
	
	impulse_direction = get_global_mouse_position() - position  # Calcula el vector de dirección
	
	var max_impulse = 1000
	
	if impulse_direction.length() > max_impulse:
		impulse_direction = impulse_direction.normalized() * max_impulse
	
	apply_central_impulse(impulse_direction)  # Aplica el impulso
	selected = false  # Deselecciona después de aplicar el impulso


func update_animation_parameters() -> void:
	
	if(direction != Vector2.ZERO):
		animation_tree["parameters/idle/blend_position"] = direction
