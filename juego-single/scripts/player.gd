extends CharacterBody2D

@onready var attack_pivot = $AttackPivot
@onready var animation_player = $AnimationPlayer
const SPEED = 1500.0


func _physics_process(delta):
	var Xdirection = Input.get_axis("left", "right")
	var Ydirection = Input.get_axis("up", "down")
	
	if Xdirection:
		velocity.x = Xdirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Ydirection:
		velocity.y = Ydirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if Input.is_action_just_pressed("attack"):
		attack_pivot.look_at(get_global_mouse_position())
		animation_player.play("attack")
	
	
	move_and_slide()
