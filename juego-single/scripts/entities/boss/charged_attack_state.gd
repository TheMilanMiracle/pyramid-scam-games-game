extends BossState
class_name ChargedAttackState

@onready var pkd_bullet: PackedScene = preload("res://scenes/entities/bullet.tscn")
@onready var timer: Timer = $AttackStateTimer


func _ready() -> void:
	timer_val = 1.

func state_ready(_timer: Timer, _boss: Boss) -> void:
	super.state_ready(_timer, _boss)
	
	boss.bullet_pivot.look_at(boss.player.global_position)
	
	boss.direction = (boss.player.global_position - boss.global_position).normalized()
	
	var bullet: Bullet = pkd_bullet.instantiate()
	get_parent().get_parent().add_child(bullet)
	
	bullet.global_position = boss.charged_bullet_marker.global_position
	bullet.rotation = boss.bullet_pivot.rotation
	bullet.SPEED_MULTIPLIER = 0.15
	bullet.DAMAGE = 3
	
	bullet.scale = Vector2(10, 10)
	bullet.modulate = Color(0.95, 0.45, 0.9)


func state_transition(machine: StateMachine) -> void:
	var state = RandomNumberGenerator.new().randi() % 100
	boss.sprite_pivot.rotation = 0
	
	if state < 65:
		machine.boss_state = machine.following_state
	else:
		machine.boss_state = machine.attack_state
	
	super.state_transition(machine)
