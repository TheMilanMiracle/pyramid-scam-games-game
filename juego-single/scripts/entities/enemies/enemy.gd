extends RigidBody2D
class_name Enemy


@export var noIA: bool = false
@export var direction: = Vector2.ZERO

var mouse_inside: bool = false
var selected: bool = false
var mouse_position = Vector2(0, 0)
var mouse_offset = Vector2(0, 0)
var new_pos = Vector2(0, 0)
var impulse_direction = Vector2.ZERO

const MAX_HEALTH: int = 3
var HEALTH: int


@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var hitbox: Hitbox = $Hitbox

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
	
	hitbox.mouse_entered.connect(
		func():
			mouse_inside = true
			if LevelController.player.selecting:
				return
			Input.set_custom_mouse_cursor(LevelController.player.hand_open)
	)
	hitbox.mouse_exited.connect(
		func():
			mouse_inside = false
			if LevelController.player.selecting:
				return
			Input.set_custom_mouse_cursor(LevelController.player.shoot_cursor)
	)
	
	
	if noIA:
		enemy_state_machine.queue_free()
	
	enemy_state_machine.enemy = self
	enemy_state_machine.enemy_state.state_ready(enemy_state_machine.state_timer, self)


func _physics_process(delta: float) -> void:
	update_animation_parameters()
	
	if selected and Input.is_action_pressed("force"):  # Apply impulse when holding a key
		apply_my_impulse()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		if not LevelController.player.selecting and mouse_inside:
			mouse_offset = position - get_global_mouse_position()
			selected = true
			LevelController.player.selecting = true
			Input.set_custom_mouse_cursor(LevelController.player.hand_closed)


func take_damage(damage: int) -> void:
	on_damage_timer.start()
	sprite.modulate = damage_color
	
	HEALTH -= damage
	
	if HEALTH == 0:
		get_parent().enemyDead()
		queue_free()


func apply_my_impulse() -> void:
	impulse_direction = get_global_mouse_position() - position
	
	var max_impulse = 1000
	
	if impulse_direction.length() > max_impulse:
		impulse_direction = impulse_direction.normalized() * max_impulse
	
	apply_central_impulse(impulse_direction)
	selected = false 
	LevelController.player.selecting = false
	Input.set_custom_mouse_cursor(LevelController.player.shoot_cursor)


func update_animation_parameters() -> void:
	
	if(direction != Vector2.ZERO):
		animation_tree["parameters/idle/blend_position"] = direction
