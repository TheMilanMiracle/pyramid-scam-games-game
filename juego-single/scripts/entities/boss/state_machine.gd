extends Node2D
class_name StateMachine

@onready var idle_state: IdleState = $IdleState
@onready var following_state: FollowingState = $FollowingState
@onready var attack_state: AttackState = $AttackState
@onready var charged_attack_state: ChargedAttackState = $ChargedAttackState

@onready var state_timer: Timer = $"../StateTimer"

@onready var boss_state: BossState = idle_state

var boss: Boss
var player: Player

func _ready() -> void:
	state_timer.timeout.connect(_on_state_timer_timeout)
	
	boss = get_parent()
	player = boss.player
	
	boss_state.state_ready(state_timer, boss)


func _process(delta: float) -> void:
	boss_state.state_process(delta, player, boss)


func _on_state_timer_timeout() -> void:
	boss_state.state_transition(self)
	boss_state.state_ready(state_timer, boss)
