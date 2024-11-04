extends Control

@onready var start: Button = %Start
@onready var credits: Button = %Credits
@onready var quit_game: Button = %"Quit game"


@export var main = PackedScene
@export var credits_scene: PackedScene
# recordar cambiar al final por el main_menu a la derecha en inspector de godot

func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	credits.pressed.connect(_on_credits_pressed)
	quit_game.pressed.connect(get_tree().quit)
	

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(main)
	

func _on_credits_pressed() -> void:
	pass
	#get_tree().change_scene_to_packed(credits_scene)
