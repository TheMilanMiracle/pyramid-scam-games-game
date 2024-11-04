extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var attack_sprite: Sprite2D = $AttackPivot/AttackSprite
@onready var attack_pivot: Node2D = $AttackPivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Hitbox = $AttackPivot/Hitbox
@onready var hitbox_shape: CollisionShape2D = $AttackPivot/Hitbox/HitboxShape
@onready var on_damage_timer: Timer = $OnDamageTimer

@onready var ui: CanvasLayer = $UI
@onready var health_bar: ProgressBar = $UI/HealthBar
@onready var death_menu: Control = $UI/death_menu

const SPEED = 1000.0
@export var HEALTH: int = 10

var defaultColor: Color = Color(0.17, 0.63, 1., 1.)
var damageColor: Color = Color(0.8, 0.2, 0.4, 1.)

func _ready() -> void:
	attack_sprite.visible = false
	hitbox.damage_dealt.connect(_on_damage_dealt)
	hitbox_shape.set_deferred("disabled", true)
	
	health_bar.max_value = HEALTH
	health_bar.value = HEALTH
	
	#death_menu.set_deferred("disabled", true)
	death_menu.hide()

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
	
	if Input.is_action_just_pressed("mouse1"):
		attack_pivot.look_at(get_global_mouse_position())
		animation_player.play("attack")
	
	move_and_slide()
	
func _on_damage_dealt() -> void:
	pass

func take_damage() -> void:
	on_damage_timer.start()
	
	sprite.modulate = damageColor
	
	HEALTH -= 1
	health_bar.value = HEALTH
	
	if HEALTH == 0:
		health_bar.hide()
		#death_menu.set_deferred("disabled", false)
		death_menu.show()
		get_tree().paused = true
