extends BossState
class_name RunState

const SPEED: int = 300


func _ready() -> void:
	timer_val = 0.5


func state_ready(_timer: Timer, _boss: Boss) -> void:
	super.state_ready(_timer, _boss)


func state_process(delta:float, player: Player, boss: CharacterBody2D) -> void:
	super.state_process(delta, player, boss)
	var direction
	
	direction = (player.global_position - boss.global_position).normalized()
	boss.direction = direction * -1
	boss.position -= direction * delta * SPEED


func state_transition(machine: BossStateMachine) -> void:
	if DISTANCE > MAX_DISTANCE:
		var state = RandomNumberGenerator.new().randi() % 100
		
		if state < 60:
			machine.boss_state = machine.following_state
		else:
			machine.boss_state = machine.attack_state
	
	super.state_transition(machine)
