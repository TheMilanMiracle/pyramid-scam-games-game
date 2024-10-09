extends RigidBody2D


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var on_damage_timer: Timer = $OnDamageTimer
#@onready var rigid_body: RigidBody2D = $RigidBody2D
@onready var rigid_body: RigidBody2D = $"."

var defaultColor: Color = Color(0.18, 0.42, 0.18, 1.)
var damageColor: Color = Color(0.8, 0.4, 0.2, 1.)


var selected = false
var mouse_position = Vector2(0, 0)
var mouse_offset = Vector2(0, 0)
var new_pos = Vector2(0, 0)
var impulse_direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if on_damage_timer.time_left == 0:
		sprite_2d.modulate = defaultColor
		
	if selected and Input.is_action_pressed("force"):  # Apply impulse when holding a key
		print("force")
		apply_my_impulse()
		
	
func take_damage() -> void:
	print("damage taken")
	on_damage_timer.start()
	
	sprite_2d.modulate = damageColor

func apply_my_impulse() -> void:
	print("toy en apply")
	impulse_direction = get_global_mouse_position() - position  # Calculate direction vector
	rigid_body.apply_central_impulse(impulse_direction * 4)  # Apply a scaled impulse
	selected = false  # Unselect after applying impulse

#func followMouse():
	#mouse_position = get_global_mouse_position()
	#new_pos = Vector2(mouse_position.x, mouse_position.y)
	#position += rigid_body.apply_central_impulse(new_pos) + mouse_offset
	#position = get_global_mouse_position() + mouse_offset
	


func _on_hurtbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("select"):
		mouse_offset = position - get_global_mouse_position()
		selected = true
		print("selected")
