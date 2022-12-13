extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# 

var b = "text"
var a = Vector2(0,0)

func _physics_process(_delta):
	a = Vector2(get_camera_screen_center())

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
