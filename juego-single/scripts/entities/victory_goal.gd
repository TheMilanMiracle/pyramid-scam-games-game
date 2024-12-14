extends Area2D
class_name VictoryGoal


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	var player = body as Player
	
	if player:
		LevelController.player_victory(player)
