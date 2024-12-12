extends BossState
class_name AttackState

@onready var pkd_bullet: PackedScene = preload("res://scenes/entities/bullet.tscn")
@onready var timer: Timer = $AttackStateTimer


func _ready() -> void:
	timer_val = 1.5


func state_ready(_timer: Timer, _boss: Boss) -> void:
	super.state_ready(_timer, _boss)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	_on_timer_timeout()


func state_transition(machine: BossStateMachine) -> void:
	boss.sprite_pivot.rotation = 0
	timer.stop()
	
	var state = RandomNumberGenerator.new().randi() % 100
	
	if state < 30:
		machine.boss_state = machine.charged_attack_state
	else:
		machine.boss_state = self
	
	super.state_transition(machine)


func _on_timer_timeout() -> void:
	boss.bullet_pivot.look_at(boss.player.global_position)
	
	boss.direction = (boss.player.global_position - boss.global_position).normalized()
	
	for i in range(-10, 11):
		var bullet: Bullet = pkd_bullet.instantiate()
		boss.get_parent().add_child(bullet)
		
		bullet.global_position = boss.normal_bullet_marker.global_position
		bullet.rotation = boss.bullet_pivot.rotation  + (0.2 * i)
		
		bullet.scale = Vector2(2.5, 2.5)
		bullet.modulate = Color(0.9, 0.4, 0.8)
		bullet.SPEED_MULTIPLIER = 0.5
		
		bullet.set_collision_layer_value(5, false)
		bullet.set_collision_layer_value(6, true)
		bullet.set_collision_mask_value(6, false)
	
	timer.start()
