extends Node2D
class_name EnemyStateMachine

@onready var enemy_idle_state: EnemyIdleState = $EnemyIdleState
@onready var enemy_shooting_state: EnemyShootingState = $EnemyShootingState
@onready var enemy_following_state: EnemyFollowingState = $EnemyFollowingState


@onready var state_timer: Timer = $StateTimer
@onready var enemy_state: EnemyState = enemy_idle_state

var enemy: Enemy
var player: Player

func _ready() -> void:
	state_timer.timeout.connect(_on_state_timer_timeout)
	
	player = LevelController.player


func _process(delta: float) -> void:
	enemy_state.state_process(delta, player, enemy)


func _on_state_timer_timeout() -> void:
	enemy_state.state_transition(self)
	enemy_state.state_ready(state_timer, enemy)
