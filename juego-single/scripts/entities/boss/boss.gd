extends CharacterBody2D
class_name Boss

@export var player: Player
@onready var marker: Marker2D = $"Bullet Pivot/Marker"
@onready var bullet_pivot: Node2D = $"Bullet Pivot"
@onready var state_timer: Timer = $StateTimer

var HEALTH: int = 10


func take_damage(damage: int) -> void:
	HEALTH -= damage
	
	if HEALTH <= 0:
		queue_free()
 
