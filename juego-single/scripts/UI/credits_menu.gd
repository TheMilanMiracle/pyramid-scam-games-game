extends Control

@onready var music: Button = $VBoxContainer/Music
@onready var song: AudioStreamPlayer = $VBoxContainer/Music/Song
@onready var music_menu: AudioStreamPlayer = $Music
@onready var return_button: Button = $VBoxContainer/Return


func _on_music_pressed() -> void:
	music_menu.stop()
	song.play()
	

func _on_song_finished() -> void:
	music_menu.play()


func _on_return_pressed() -> void:
	LevelController.tree.change_scene_to_packed(LevelController.pkd_main_menu)
