extends Node2D
class_name BossState

var timer_val: float
var boss: Boss

func state_ready(_timer: Timer, _boss: Boss) -> void:
	boss = _boss
	_timer.wait_time = timer_val
	_timer.start()


func state_process(delta:float, player: Player, boss: CharacterBody2D) -> void:
	pass


func state_transition(machine: StateMachine) -> void:
	machine.state_timer.start()
