extends Control
class_name MainMenu

@onready var start: Button = %Start
@onready var credits: Button = %Credits
@onready var quit_game: Button = %"Quit game"

@export var main = PackedScene
@export var credits_scene: PackedScene
# recordar cambiar al final por el main_menu a la derecha en inspector de godot

func _ready() -> void:
	LevelController.main_menu_ready(self)
