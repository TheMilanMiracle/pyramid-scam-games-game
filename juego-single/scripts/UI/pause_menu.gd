extends CanvasLayer

@onready var resume: Button = %Resume
@onready var restart: Button = %Restart
@onready var main_menu: Button = %"Main Menu"
@onready var quit_game: Button = %"Quit game"

#@onready var world: PackedScene = preload("res://scenes/world.tscn")

func _ready() -> void:
	resume.pressed.connect(_on_resume_pressed)
	restart.pressed.connect(_on_restart_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)
	quit_game.pressed.connect(_on_exit_pressed)
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		visible = not visible
		get_tree().paused = visible

func _on_resume_pressed() -> void:
	hide()
	get_tree().paused = false

func _on_restart_pressed() -> void:
	get_tree().paused = false
	LevelController.change_to_level(LevelController.current_level)
	
func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	LevelController.tree.change_scene_to_packed(LevelController.pkd_main_menu)

func _on_exit_pressed() -> void:
	get_tree().quit()
