extends Node


var chunk = preload("res://test-scenes/level-controller/chunk.tscn")

func _ready():
	var izq_hallway = chunk.instantiate()
	var der_hallway = chunk.instantiate()
	var upp_hallway = chunk.instantiate()
	var down_hallway = chunk.instantiate()
	
	add_child(izq_hallway)
	add_child(der_hallway)
	add_child(upp_hallway)
	add_child(down_hallway)
	
	izq_hallway.position = Vector2(-6 * 16, 16 * 3)
	der_hallway.position = Vector2(16 * 16, 16 * 3)
	
	upp_hallway.rotation += PI/2
	upp_hallway.position = Vector2(8 * 16, -6 * 16)
	
	down_hallway.rotation += PI/2
	down_hallway.position = Vector2(8 * 16, 10 * 16)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
