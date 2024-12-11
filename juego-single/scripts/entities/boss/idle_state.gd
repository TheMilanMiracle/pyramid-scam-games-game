extends BossState
class_name IdleState

const SPEED: int = 150
var val: int

func _ready() -> void:
	timer_val = 2


func state_ready(_timer: Timer, _boss: Boss) -> void:
	super.state_ready(_timer, _boss)


func state_process(delta:float, player: Player, boss: CharacterBody2D) -> void:
	var direction
	boss.direction = (player.global_position - boss.global_position).normalized()


func state_transition(machine: StateMachine) -> void:
	var state = RandomNumberGenerator.new().randi() % 100
	
	if state < 40:
		machine.boss_state = machine.attack_state
	elif state < 90:
		machine.boss_state = machine.following_state
	else:
		machine.boss_state = self
	
	super.state_transition(machine)
