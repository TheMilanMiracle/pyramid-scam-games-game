extends BossState
class_name FollowingState


const SPEED: int = 250

func _ready() -> void:
	timer_val = 0.75
	pass


func state_process(delta:float, player: Player, boss: CharacterBody2D) -> void:
	var direction = (player.global_position - boss.global_position).normalized()
	var velocity = direction * SPEED * delta
	
	if boss.global_position.distance_to(player.global_position) > MAX_DISTANCE:
		boss.velocity = velocity
		boss.direction = direction
	else:
		boss.velocity = -velocity
		boss.direction = -1 * direction
	
	var collision = boss.move_and_collide(boss.velocity)
	if collision:
		boss.velocity = Vector2.ZERO


func state_transition(machine: BossStateMachine) -> void:
	var state = RandomNumberGenerator.new().randi() % 100
	
	if state < 40:
		machine.boss_state = machine.attack_state
	elif state < 60:
		machine.boss_state = machine.idle_state
	else:
		machine.boss_state = self
	
	super.state_transition(machine)
