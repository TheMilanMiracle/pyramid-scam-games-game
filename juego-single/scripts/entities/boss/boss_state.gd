extends Node2D
class_name BossState

var timer_val: float = 2.
var boss: Boss

const MAX_DISTANCE: int =  400
var DISTANCE: float

func state_ready(_timer: Timer, _boss: Boss) -> void:
	boss = _boss
	_timer.wait_time = timer_val
	_timer.start()


func state_process(delta:float, player: Player, boss: CharacterBody2D) -> void:
	DISTANCE = boss.global_position.distance_to(player.global_position)


func state_transition(machine: BossStateMachine) -> void:
	if DISTANCE <= MAX_DISTANCE:
		machine.boss_state = machine.run_state
	
	machine.state_timer.start()
