extends Camera2D

@export var camera_speed = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _input(event):
	if event is InputEvent:
		if event.is_action_pressed("up"):
			position.y -= camera_speed
		if event.is_action_pressed("down"):
			position.y += camera_speed
		if event.is_action_pressed("left"):
			position.x -= camera_speed
		if event.is_action_pressed("right"):
			position.x += camera_speed
