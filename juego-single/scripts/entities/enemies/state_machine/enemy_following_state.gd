extends EnemyState
class_name EnemyFollowingState

const SPEED: int = 100


func state_ready(_timer: Timer, _enemy: Enemy) -> void:
	timer_val = 0.5
	super.state_ready(_timer, _enemy)
	
	_enemy = _enemy as ShootingEnemy
	if _enemy:
		enemy.path_pivot.process_mode = Node.PROCESS_MODE_DISABLED


func state_process(delta: float, player: Player, enemy: Enemy) -> void:
	var shooting_enemy: ShootingEnemy = enemy as ShootingEnemy
	var direction = (player.global_position - enemy.global_position).normalized()
	var velocity = direction * SPEED * delta
	
	if shooting_enemy.global_position.distance_to(player.global_position) > RANGE:
		shooting_enemy.velocity = velocity
		shooting_enemy.direction = direction
	else:
		shooting_enemy.velocity = -velocity
		shooting_enemy.direction = -1 * direction

	var collision = shooting_enemy.move_and_collide(shooting_enemy.velocity)
	if collision:
		shooting_enemy.velocity = - velocity * 5
		shooting_enemy.direction = -1 * direction


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
