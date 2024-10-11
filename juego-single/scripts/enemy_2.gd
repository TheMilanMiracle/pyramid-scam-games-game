extends CharacterBody2D

var selected = false
var mouse_position = Vector2(0, 0)
var mouse_offset = Vector2(0, 0)
var new_pos = Vector2(0, 0)
var impulse_direction = Vector2.ZERO

func _physics_process(delta):

	# Simulate an impulse/force when a condition is met (e.g., mouse click)
	if Input.is_action_just_pressed("apply_impulse"):
		apply_impulse()

func apply_impulse():
	var direction = (get_global_mouse_position() - position).normalized()
	velocity += direction * 500  # Apply a "force"

func algo():
	if Input.is_action_pressed("select"):
		mouse_offset = position - get_global_mouse_position()
		selected = true
		print("selected")
