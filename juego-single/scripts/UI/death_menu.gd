extends Control

@onready var try_again: Button = %"Try again"
@onready var main_menu: Button = %"Main Menu"
@onready var exit: Button = %Exit

#@onready var world: PackedScene = preload("res://scenes/world.tscn")

func _ready() -> void:
	try_again.pressed.connect(_on_try_again_press)
	main_menu.pressed.connect(_on_main_menu_press)
	exit.pressed.connect(_on_exit_press)

func _on_try_again_press() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_main_menu_press() -> void:
	pass

func _on_exit_press() -> void:
	get_tree().quit()
