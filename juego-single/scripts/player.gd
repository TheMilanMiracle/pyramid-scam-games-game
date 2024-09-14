extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var attack_sprite: Sprite2D = $AttackPivot/AttackSprite
@onready var attack_pivot: Node2D = $AttackPivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Hitbox = $AttackPivot/Hitbox
@onready var hitbox_shape: CollisionShape2D = $AttackPivot/Hitbox/HitboxShape
@onready var on_damage_timer: Timer = $OnDamageTimer

const SPEED = 1000.0

var defaultColor: Color = Color(0.17, 0.63, 1., 1.)
var damageColor: Color = Color(0.8, 0.2, 0.4, 1.)

func _ready() -> void:
	attack_sprite.visible = false
	hitbox.damage_dealt.connect(_on_damage_dealt)
	hitbox_shape.set_deferred("disabled", true)
	

func _physics_process(delta) -> void:
	var Xdirection = Input.get_axis("left", "right")
	var Ydirection = Input.get_axis("up", "down")
	
	if on_damage_timer.time_left == 0:
		sprite.modulate = defaultColor
	
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
	
func _on_damage_dealt() -> void:
	print("damage dealt")

func take_damage() -> void:
	print("damage taken")
	on_damage_timer.start()
	
	sprite.modulate = damageColor
