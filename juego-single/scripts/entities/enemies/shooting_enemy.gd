extends Enemy
class_name ShootingEnemy

const bullet = preload("res://scenes/entities/bullet.tscn")
@onready var left_marker: Marker2D = $PathPivot/LMarker
@onready var left_direction: Marker2D = $PathPivot/LMarker/LEnemyDirection
@onready var right_marker: Marker2D = $PathPivot/RMarker
@onready var right_direction: Marker2D = $PathPivot/RMarker/REnemyDirection
@onready var shoot_cooldown: Timer = $PathPivot/ShootCooldown
@onready var path_pivot: Node2D = $PathPivot
@onready var hit_sfx: AudioStreamPlayer = $HitSFX

@onready var backing_timer: Timer = $BackingTimer
var backing: bool = false

func _ready() -> void:
	super._ready()
	
	if noIA:
		path_pivot.process_mode = Node.PROCESS_MODE_INHERIT
		path_pivot.look_at(global_position + direction)
	
	shoot_cooldown.timeout.connect(shoot)
	backing_timer.timeout.connect(func(): backing = false)

func hit_sound() -> void:
	hit_sfx.play()

func shoot():
	var left_bullet: Bullet = bullet.instantiate()
	var right_bullet: Bullet = bullet.instantiate()
	
	get_parent().add_child(left_bullet)
	get_parent().add_child(right_bullet)
	
	left_bullet.global_position = left_marker.global_position
	right_bullet.global_position = right_marker.global_position
	
	left_bullet.look_at(left_direction.global_position)
	right_bullet.look_at(right_direction.global_position)
	
	left_bullet.SPEED_MULTIPLIER = 0.8
	right_bullet.SPEED_MULTIPLIER = 0.8
	
	left_bullet.modulate = Color(0.5, 0.1, 0.1)
	right_bullet.modulate = Color(0.5, 0.1, 0.1)
	
	left_bullet.set_collision_layer_value(5, false)
	left_bullet.set_collision_layer_value(3, true)
	#left_bullet.set_collision_mask_value(3, false)
	
	right_bullet.set_collision_layer_value(5, false)
	right_bullet.set_collision_layer_value(3, true)
	#right_bullet.set_collision_mask_value(3, false)
	
	left_bullet.SPEED_MULTIPLIER = 1.7
	right_bullet.SPEED_MULTIPLIER = 1.7
