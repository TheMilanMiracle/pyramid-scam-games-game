extends BossState
class_name AttackState

@onready var pkd_bullet: PackedScene = preload("res://scenes/entities/bullet.tscn")
@onready var timer: Timer = $AttackStateTimer


func _ready() -> void:
	timer_val = 3.0

func state_ready(_timer: Timer, _boss: Boss) -> void:
	super.state_ready(_timer, _boss)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	_on_timer_timeout()


func state_transition(machine: StateMachine) -> void:
	timer.stop()
	
	var state = RandomNumberGenerator.new().randi() % 10
	
	if state < 3:
		machine.boss_state = machine.following_state
	elif state < 5:
		machine.boss_state = machine.idle_state
	elif state < 8:
		machine.boss_state = machine.charged_attack_state
	else:
		machine.boss_state = self
	
	super.state_transition(machine)


func _on_timer_timeout() -> void:
	boss.bullet_pivot.look_at(boss.player.global_position)
	
	for i in range(-2, 3):
		var bullet: Bullet = pkd_bullet.instantiate()
		get_parent().get_parent().add_child(bullet)
			
		bullet.global_position = boss.marker.global_position
		bullet.rotation = boss.bullet_pivot.rotation  + (0.1 * i)
		
		bullet.scale = Vector2(2.5, 2.5)
		bullet.modulate = Color(0.9, 0.4, 0.8)
		bullet.SPEED_MULTIPLIER = 0.7
		
	timer.start()
