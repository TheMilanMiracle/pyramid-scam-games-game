extends EnemyState
class_name EnemyIdleState


@onready var path_pivot: Node2D = $PathPivot


func state_ready(_timer: Timer, _enemy: Enemy) -> void:
	timer_val = 0.5
	super.state_ready(_timer, _enemy)
	
	_enemy = _enemy as ShootingEnemy
	if _enemy:
		_enemy.path_pivot.process_mode = Node.PROCESS_MODE_DISABLED


func state_transition(machine: EnemyStateMachine) -> void:
	if machine.enemy.global_position.distance_to(machine.player.global_position) <= VISION_RANGE:
		machine.enemy_state = machine.enemy_following_state
	else:
		machine.enemy_state = self
	super.state_transition(machine)
