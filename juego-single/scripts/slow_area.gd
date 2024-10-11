extends Area2D

@onready var slow_area_sprite: Sprite2D = $SlowAreaSprite
@onready var slow_area_shape: CollisionShape2D = $SlowAreaShape

@onready var cooldown_timer: Timer = %CooldownTimer
@onready var action_timer: Timer = %ActionTimer
@onready var cooldown_progress: TextureProgressBar = %CooldownProgress
@onready var area_progress: TextureProgressBar = %AreaProgress

@onready var blue_particles: CPUParticles2D = $BlueParticles
@onready var cyan_particles: CPUParticles2D = $CyanParticles

@export var SLOW: float = 0.2

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
	action_timer.timeout.connect(_on_action_timer_timeout)
	
	slow_area_shape.disabled = true
	slow_area_sprite.visible = false


func _process(delta: float) -> void:
	if cooldown_timer.time_left > 0:
		cooldown_progress.value =  (cooldown_timer.wait_time - cooldown_timer.time_left) / cooldown_timer.wait_time * 100
	
	if action_timer.time_left > 0:
		area_progress.value = (action_timer.wait_time - action_timer.time_left) / action_timer.wait_time * 100


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				if cooldown_timer.time_left == 0.:
					position = get_viewport().get_camera_2d().get_global_mouse_position()
					slow_area_shape.disabled = false
					slow_area_sprite.visible = true
					action_timer.start()
					
					blue_particles.emitting = true
					cyan_particles.emitting = true
					
					cooldown_timer.start()
					cooldown_progress.value = 0


func _on_action_timer_timeout() -> void:
	slow_area_shape.disabled = true
	slow_area_sprite.visible = false
	
	blue_particles.emitting = false
	cyan_particles.emitting = false


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("slow_down") and area.has_method("speed_up"):
		area.slow_down(SLOW)


func _on_area_exited(area: Area2D) -> void:
	if area.has_method("slow_down") and area.has_method("speed_up"):
		area.speed_up()
