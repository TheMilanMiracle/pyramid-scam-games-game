extends BossState
class_name IdleState

const SPEED: int = 150
var val: int

func _ready() -> void:
	timer_val = 1.5

func state_ready(_timer: Timer, _boss: Boss) -> void:
	super.state_ready(_timer, _boss)
	val = RandomNumberGenerator.new().randi() % 3


func state_process(delta:float, player: Player, boss: CharacterBody2D) -> void:
	var direction
	match val:
		0:
			direction = (player.global_position - boss.global_position).normalized()
			boss.position -= SPEED * delta * direction
		
		1: 
			direction = (player.global_position - boss.global_position).normalized()
			direction = Vector2(
				(int(direction[0]) + 1) % 2,
				(int(direction[1]) + 1) % 2
			)
			
			boss.position += SPEED * delta * direction
		
		2:
			direction = (player.global_position - boss.global_position).normalized()
			direction = Vector2(
				(int(direction[0]) + 1) % 2,
				(int(direction[1]) + 1) % 2
			)
			
			boss.position -= SPEED * delta * direction


func state_transition(machine: StateMachine) -> void:
	var state = RandomNumberGenerator.new().randi() % 10
	
	if state < 4:
		machine.boss_state = machine.attack_state
	elif state < 8:
		machine.boss_state = machine.following_state
	else:
		machine.boss_state = self
	
	super.state_transition(machine)
