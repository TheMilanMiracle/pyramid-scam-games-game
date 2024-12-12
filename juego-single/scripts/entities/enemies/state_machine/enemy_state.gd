extends Node2D
class_name EnemyState


var timer_val: float = 2.
var enemy: Enemy

@export var VISION_RANGE: int = 1000
@export var RANGE: int = 1000


func state_ready(_timer: Timer, _enemy: Enemy) -> void:
	enemy = _enemy
	_timer.wait_time = timer_val
	_timer.start()


func state_process(delta:float, player: Player, enemy: Enemy) -> void:
	pass


func state_transition(machine: EnemyStateMachine) -> void:
	machine.state_timer.start()
