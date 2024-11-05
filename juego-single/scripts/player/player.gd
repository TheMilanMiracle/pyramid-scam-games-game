extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var attack_sprite: Sprite2D = $AttackPivot/AttackSprite
@onready var attack_pivot: Node2D = $AttackPivot
@onready var hitbox: Hitbox = $AttackPivot/Hitbox
@onready var hitbox_shape: CollisionShape2D = $AttackPivot/Hitbox/HitboxShape
@onready var on_damage_timer: Timer = $OnDamageTimer
@onready var damaged_timer: Timer = $DamagedTimer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree


@onready var ui: CanvasLayer = $UI
@onready var health_bar: ProgressBar = $UI/HealthBar
@onready var death_menu: Control = $UI/death_menu
@onready var shield_cd_bar: ProgressBar = $UI/ShieldCDBar
@onready var shield_bar: ProgressBar = $UI/ShieldBar

const SPEED = 1000.0
var direction: Vector2 = Vector2.ZERO
@export var HEALTH: int = 10
@export var SHIELD: int = 5
@export var MAX_SHIELD: int = 5

var defaultColor: Color = Color(0.17, 0.63, 1., 1.)
var damageColor: Color = Color(0.8, 0.2, 0.4, 1.)

func _ready() -> void:
	animation_tree.active = true
	attack_sprite.visible = false
	hitbox.damage_dealt.connect(_on_damage_dealt)
	hitbox_shape.set_deferred("disabled", true)
	
	on_damage_timer.timeout.connect(func():sprite.modulate = defaultColor)
	damaged_timer.timeout.connect(func():SHIELD=MAX_SHIELD; shield_bar.value = SHIELD)
	
	health_bar.max_value = HEALTH
	health_bar.value = HEALTH
	
	shield_bar.max_value = SHIELD
	shield_bar.value = SHIELD


func _physics_process(delta) -> void:
	#HUD
	if damaged_timer.time_left:
		shield_cd_bar.value = (damaged_timer.wait_time - damaged_timer.time_left) / damaged_timer.wait_time * 100
	
	#MOVEMENT
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
	
	if Xdirection != 0:
		attack_pivot.scale.x = sign(Xdirection)
	direction = Input.get_vector("left","right","up","down").normalized()
	
	update_animation_parameters()
	#if Input.is_action_just_pressed("mouse1"):
	#	attack_pivot.look_at(get_global_mouse_position())
	#	animation_player.play("attack")
	
	move_and_slide()
	
func _on_damage_dealt() -> void:
	pass

func take_damage() -> void:
	on_damage_timer.start()
	damaged_timer.start()
	
	sprite.modulate = damageColor
	
	if SHIELD:
		SHIELD -= 1
		shield_bar.value = SHIELD
		return
	
	HEALTH -= 1
	health_bar.value = HEALTH
	if HEALTH == 0:
		health_bar.hide()
		death_menu.show()
		get_tree().paused = true

func update_animation_parameters() -> void:
	animation_tree["parameters/conditions/idle_or_moving"] = true
	
	if(Input.is_action_just_pressed("mouse1")):
		animation_tree["parameters/conditions/attack"] = true
		attack_pivot.look_at(get_global_mouse_position())
		attack_sprite.visible = true
		animation_player.play("attack")
		
	else:
		attack_sprite.visible = false
		animation_tree["parameters/conditions/attack"] = false
	
	if(direction != Vector2.ZERO):
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/attack/blend_position"] = direction
