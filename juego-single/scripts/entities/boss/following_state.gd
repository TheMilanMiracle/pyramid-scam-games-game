extends BossState
class_name FollowingState


const SPEED: int = 100

func _ready() -> void:
	timer_val = 2.


func state_process(delta:float, player: Player, boss: CharacterBody2D) -> void:
	var direction = (player.global_position - boss.global_position).normalized()
	boss.position += SPEED * delta * direction


func state_transition(machine: StateMachine) -> void:
	var state = RandomNumberGenerator.new().randi() % 10
	
	if state < 3:
		machine.boss_state = machine.attack_state
	elif state < 6:
		machine.boss_state = machine.idle_state
	else:
		machine.boss_state = self
	
	super.state_transition(machine)
