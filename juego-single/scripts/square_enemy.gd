extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var on_damage_timer: Timer = $OnDamageTimer

var defaultColor: Color = Color(0.18, 0.42, 0.18, 1.)
var damageColor: Color = Color(0.8, 0.4, 0.2, 1.)

func _physics_process(delta: float) -> void:
	if on_damage_timer.time_left == 0:
		sprite_2d.modulate = defaultColor
		
	
func take_damage() -> void:
	print("damage taken")
	on_damage_timer.start()
	
	sprite_2d.modulate = damageColor
