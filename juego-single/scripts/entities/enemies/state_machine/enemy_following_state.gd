extends EnemyState
class_name EnemyFollowingState

const SPEED: int = 300


func state_ready(_timer: Timer, _enemy: Enemy) -> void:
	super.state_ready(_timer, _enemy)
	
	_enemy = _enemy as ShootingEnemy
	if _enemy:
		enemy.path_pivot.process_mode = Node.PROCESS_MODE_DISABLED


func state_process(delta: float, player: Player, enemy: Enemy) -> void:
	var direction = (player.global_position - enemy.global_position).normalized()
	
	enemy.apply_central_force(direction * SPEED)
	enemy.direction = direction



func state_transition(machine: EnemyStateMachine) -> void:
	if enemy.global_position.distance_to(machine.player.global_position) > VISION_RANGE:
		machine.enemy_state = machine.enemy_idle_state
	else:
		var state = RandomNumberGenerator.new().randi() % 100
		
		if state < 30:
			machine.enemy_state = machine.enemy_shooting_state
		else:
			machine.enemy_state = self
	
	super.state_transition(machine)
