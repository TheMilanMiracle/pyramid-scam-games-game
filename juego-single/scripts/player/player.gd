extends CharacterBody2D
class_name Player

@onready var camera: Camera2D = $Camera
@onready var pivot: Node2D = $Pivot
@onready var sprite: Sprite2D = $Pivot/MainSprite
@onready var death_sprite: Sprite2D = $Pivot/DeathSprite
@onready var on_damage_timer: Timer = $OnDamageTimer
@onready var damaged_timer: Timer = $DamagedTimer
@onready var overheat_timer: Timer = $OverheatTimer
@onready var decrease_heat_timer: Timer = $DecreaseHeatTimer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree

@onready var ui: CanvasLayer = $UI
@onready var health_bar: ProgressBar = $UI/HealthBar
@onready var death_menu: Control = $UI/death_menu
@onready var shield_cd_bar: ProgressBar = $UI/ShieldCDBar
@onready var shield_bar: ProgressBar = $UI/ShieldBar
@onready var heat_bar: ProgressBar = $UI/HeatBar
@onready var cooldown_progress: ProgressBar = %CooldownProgress
@onready var victory_menu: Control = $UI/victory_menu

@onready var qol_heat_bar: ProgressBar = $QolHeatBar

var camera_toggle: bool = false

const SPEED = 1000.0
var direction: Vector2 = Vector2.ZERO
@export var HEALTH: int
const MAX_HEALTH: int = 10
@export var SHIELD: int = 5
@export var MAX_SHIELD: int = 5
var HEAT: int = 0
const MAX_HEAT: int = 20
var overheated: bool = false

var default_color: Color
var damage_color: Color = Color(0.8, 0.2, 0.4, 1.)

@export var slow_area: Area2D
var slow_area_cooldown_timer: Timer


func _ready() -> void:
	HEALTH = LevelController.current_player_hp
	
	default_color = sprite.modulate
	
	animation_tree.active = true
	
	on_damage_timer.timeout.connect(func():sprite.modulate = default_color)
	damaged_timer.timeout.connect(func():SHIELD=MAX_SHIELD; shield_bar.value = SHIELD)
	overheat_timer.timeout.connect(_on_heat_reset)
	decrease_heat_timer.timeout.connect(_on_heat_decrease)
	
	health_bar.max_value = MAX_HEALTH
	health_bar.value = HEALTH
	
	shield_bar.max_value = SHIELD
	shield_bar.value = SHIELD
	
	heat_bar.max_value = 100
	qol_heat_bar.max_value = 100
	heat_bar.value = 0
	
	slow_area_cooldown_timer = slow_area.cooldown_timer
	cooldown_progress.value = 100


func _physics_process(delta) -> void:
	#CAMERA
	_point_camera()
	
	#HUD
	if damaged_timer.time_left:
		shield_cd_bar.value = (damaged_timer.wait_time - damaged_timer.time_left) / damaged_timer.wait_time * 100
	
	if slow_area_cooldown_timer.time_left:
		cooldown_progress.value = (slow_area_cooldown_timer.wait_time - slow_area_cooldown_timer.time_left)\
								/ slow_area_cooldown_timer.wait_time * 100
	
	if overheated:
		heat_bar.value = overheat_timer.time_left / overheat_timer.wait_time * 100
	else:
		heat_bar.value = float(HEAT) / float(MAX_HEAT) * 100
	
	if HEAT:
		if overheated:
			qol_heat_bar.value = overheat_timer.time_left / overheat_timer.wait_time * 100
		else:
			qol_heat_bar.show()
			qol_heat_bar.value = float(HEAT) / float(MAX_HEAT) * 100
	else:
		qol_heat_bar.hide()
	
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
		pivot.scale.x = sign(Xdirection)
	direction = Input.get_vector("left","right","up","down").normalized()
	
	update_animation_parameters()
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				_shoot()
				_point_camera()
	
	if event.is_action_released("space"):
		camera_toggle = not camera_toggle


func _on_damage_dealt() -> void:
	pass


func take_damage(damage: int) -> void:
	on_damage_timer.start()
	damaged_timer.start()
	
	sprite.modulate = damage_color
	
	if SHIELD:
		SHIELD = max(SHIELD - damage, 0)
		shield_bar.value = SHIELD
		return
	
	HEALTH = max(HEALTH - damage, 0)
	health_bar.value = HEALTH
	if HEALTH == 0:
		sprite.hide()
		death_sprite.show()
		animation_tree["parameters/conditions/death"] = true
		await get_tree().create_timer(0.5).timeout
		death_menu.show()
		get_tree().paused = true


func _shoot() -> void:
	if not overheated:
		var pivot = $"BulletPivot"
		var marker = $"BulletPivot/BulletMarker"
		var bullet_color = Color(0.6, 0.7, 0.8)
		var bullet = load("res://scenes/entities/bullet.tscn")
		
		pivot.look_at(get_global_mouse_position())
		direction = (get_global_mouse_position() - global_position).normalized()
		update_animation_parameters()
		
		var _bullet: Bullet = bullet.instantiate()
		_bullet.modulate = bullet_color
		get_parent().add_child(_bullet)
		
		_bullet.global_position = marker.global_position
		_bullet.rotation = pivot.rotation
		_bullet.SPEED_MULTIPLIER = 2.
		
		_bullet.set_collision_layer_value(5, false)
		_bullet.set_collision_layer_value(2, true)
		
		HEAT = min(HEAT + 1, MAX_HEAT)
		decrease_heat_timer.start()
		
		if HEAT == MAX_HEAT:
			_overheat()


func _on_heat_decrease() -> void:
	if overheated:
		return
	
	HEAT = max(HEAT - 1, 0)


func _overheat() -> void:
	overheated = true
	overheat_timer.start()
	
	heat_bar.get_theme_stylebox("fill").bg_color = Color("c9283c")


func _on_heat_reset() -> void:
	overheated = false
	HEAT = 0
	
	heat_bar.get_theme_stylebox("fill").bg_color = Color("c9803c")


func _point_camera() -> void:
	const max_move = 400
	const move_speed = 25
	var mouse_direction = (get_local_mouse_position() - camera.position).normalized()
	
	if not camera_toggle:
		camera.position = Vector2(
			move_toward(camera.position.x, 0, move_speed * 5),
			move_toward(camera.position.y, 0, move_speed * 5),
		)
		return
	
	camera.position = Vector2(
		move_toward(camera.position.x, max_move * mouse_direction[0], move_speed),
		move_toward(camera.position.y, max_move * mouse_direction[1], move_speed),
	)


func update_animation_parameters() -> void:
	animation_tree["parameters/conditions/idle_or_moving"] = true
	
	if(direction != Vector2.ZERO):
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/attack/blend_position"] = direction
