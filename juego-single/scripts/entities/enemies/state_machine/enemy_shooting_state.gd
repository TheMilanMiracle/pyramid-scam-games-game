extends EnemyState
class_name EnemyShootingState


const SPEED: int = 300


func state_ready(_timer: Timer, _enemy: Enemy) -> void:
	super.state_ready(_timer, _enemy)
	
	_enemy = _enemy as ShootingEnemy
	if _enemy:
		_enemy.path_pivot.process_mode = Node.PROCESS_MODE_INHERIT
		


func state_process(delta:float, player: Player, enemy: Enemy) -> void:
	var direction = (player.global_position - enemy.global_position).normalized()
	
	#enemy.position += SPEED * direction * delta
	
	enemy.direction = direction
	enemy.path_pivot.look_at(LevelController.player.global_position)


func state_transition(machine: EnemyStateMachine) -> void:
	if enemy.global_position.distance_to(machine.player.global_position) > VISION_RANGE:
		machine.enemy_state = machine.enemy_idle_state
	else:
		machine.enemy_state = self
	
	super.state_transition(machine)
