extends Control

@onready var try_again: Button = %"Try again"
@onready var main_menu: Button = %"Main Menu"
@onready var exit: Button = %Exit


func _ready() -> void:
	try_again.pressed.connect(_on_try_again_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)
	exit.pressed.connect(_on_exit_pressed)


func _on_try_again_pressed() -> void:
	get_tree().paused = false
	LevelController.current_level = 0
	LevelController.change_to_level(0)


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	LevelController.tree.change_scene_to_packed(LevelController.pkd_main_menu)


func _on_exit_pressed() -> void:
	get_tree().quit()
