extends CharacterBody2D
class_name Boss

@export var player: Player
@onready var sprite: Sprite2D = $SpritePivot/Sprite
@onready var normal_bullet_marker: Marker2D = $"Bullet Pivot/NormalBulletMarker"
@onready var charged_bullet_marker: Marker2D = $"Bullet Pivot/ChargedBulletMarker"
@onready var bullet_pivot: Node2D = $"Bullet Pivot"
@onready var sprite_pivot: Node2D = $SpritePivot
@onready var state_timer: Timer = $StateTimer
@onready var on_damage_timer: Timer = $OnDamageTimer

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var health_bar: ProgressBar = $HealthBar

var default_color: Color
var damage_color: Color = Color(0.8, 0.2, 0.4, 1.)

var direction: Vector2 = Vector2.ZERO
var HEALTH: int = 100


func _ready() -> void:
	default_color = sprite.modulate
	
	animation_tree.active = true
	health_bar.hide()
	
	on_damage_timer.timeout.connect(func(): sprite.modulate = default_color)


func _process(delta: float) -> void:
	update_animation_parameters()
	
	if HEALTH < 100:
		health_bar.show()
		health_bar.value = HEALTH


func take_damage(damage: int) -> void:
	on_damage_timer.start()
	sprite.modulate = damage_color
	
	HEALTH -= damage
	
	if HEALTH <= 0:
		get_parent().enemyDead()
		animation_tree["parameters/conditions/dead"] = true
		queue_free()
 


func update_animation_parameters() -> void:
	
	if(direction != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = direction
