extends Node2D


@onready var tutorial: PackedScene = preload("res://scenes/rooms/tutorial_room.tscn")
@onready var room_01: PackedScene = preload("res://scenes/rooms/room_01.tscn")
@onready var room_02: PackedScene = preload("res://scenes/rooms/room_02.tscn")
@onready var room_03: PackedScene = preload("res://scenes/rooms/room_03.tscn")
@onready var boss_room: PackedScene = preload("res://scenes/rooms/boss_room.tscn")

@onready var pkd_main_menu: PackedScene = preload("res://scenes/UI/main_menu.tscn")
@onready var credits: PackedScene = preload("res://scenes/UI/credits_menu.tscn")

@onready var ROOMS: = [
	tutorial,
	room_03,
	room_02,
	boss_room
]

var current_level: int = 0
var current_player_hp: int = 10

var tree: SceneTree
var main_menu: MainMenu
var player: Player


func _ready() -> void:
	tree = get_tree()


func main_menu_ready(_main_menu: MainMenu) -> void:
	main_menu = _main_menu
	
	main_menu.start.pressed.connect(_on_main_menu_start_press)
	main_menu.credits.pressed.connect(_on_main_menu_credits_press)
	main_menu.quit_game.pressed.connect(func(): tree.quit())


func _on_main_menu_start_press() -> void:
	tree.change_scene_to_packed(ROOMS[current_level])
	main_menu.start.disconnect("pressed", _on_main_menu_start_press)


func _on_main_menu_credits_press() -> void:
	tree.change_scene_to_packed(credits)


func change_to_level(idx: int) -> void:
	tree.change_scene_to_packed(ROOMS[idx])


func player_victory(player: Player) -> void:
	current_player_hp = player.HEALTH
	current_level += 1

	tree.change_scene_to_packed(ROOMS[current_level])
