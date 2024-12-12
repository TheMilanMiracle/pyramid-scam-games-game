extends Control

@onready var music: Button = $VBoxContainer/Music
@onready var song: AudioStreamPlayer = $VBoxContainer/Music/Song
@onready var music_menu: AudioStreamPlayer = $Music


func _on_music_pressed() -> void:
	music_menu.stop()
	song.play()
	

func _on_song_finished() -> void:
	music_menu.play()
