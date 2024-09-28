extends CharacterBody2D

const bulletPath = preload("res://scenes/enemy_bullet.tscn")
@onready var marker_2d: Marker2D = $Path2D/PathFollow2D/Marker2D
@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var marker_2d_2: Marker2D = $Path2D/PathFollow2D2/Marker2D

func take_damage_en():
	queue_free()

func _ready() -> void:
	shoot_cooldown.timeout.connect(shoot)
	

func shoot():
	var bullet = bulletPath.instantiate()
	var bullet_2 = bulletPath.instantiate()
	add_child(bullet)
	add_child(bullet_2)
	bullet.global_position = marker_2d.global_position
	bullet.global_rotation = marker_2d.global_rotation
	bullet_2.global_position = marker_2d_2.global_position
	bullet_2.global_rotation = marker_2d_2.global_rotation
