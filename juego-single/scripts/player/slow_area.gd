extends Area2D
class_name SlowArea

@onready var slow_area_sprite: Sprite2D = $SlowAreaSprite
@onready var slow_area_shape: CollisionShape2D = $SlowAreaShape

@onready var cooldown_timer: Timer = %CooldownTimer
@onready var action_timer: Timer = %ActionTimer

@onready var blue_particles: CPUParticles2D = $BlueParticles
@onready var cyan_particles: CPUParticles2D = $CyanParticles

@export var SLOW: float = 0.2
var action_position: Vector2i = Vector2i.ZERO


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
	action_timer.timeout.connect(_on_action_timer_timeout)
	
	slow_area_shape.disabled = true
	slow_area_sprite.visible = false


func _process(delta: float) -> void:
	global_position = action_position


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				if cooldown_timer.time_left == 0.:
					action_position = get_global_mouse_position()
					slow_area_shape.disabled = false
					slow_area_sprite.visible = true
					action_timer.start()
					
					blue_particles.emitting = true
					cyan_particles.emitting = true
					
					cooldown_timer.start()


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
