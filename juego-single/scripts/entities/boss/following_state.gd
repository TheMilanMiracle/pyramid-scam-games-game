extends BossState
class_name FollowingState


const SPEED: int = 200

func _ready() -> void:
	#timer_val = 2.
	pass


func state_process(delta:float, player: Player, boss: CharacterBody2D) -> void:
	var direction = (player.global_position - boss.global_position).normalized()
	boss.position += SPEED * delta * direction
	boss.direction = direction

func state_transition(machine: StateMachine) -> void:
	var state = RandomNumberGenerator.new().randi() % 100
	
	if state < 40:
		machine.boss_state = machine.attack_state
	elif state < 60:
		machine.boss_state = machine.idle_state
	else:
		machine.boss_state = self
	
	super.state_transition(machine)
