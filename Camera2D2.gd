extends Camera2D


# Declare member variables here. Examples:
var a = Vector2($"MenuMensagem".get_global_position())
var b = Vector2(get_global_position())

func _physics_process(delta):
	b = Vector2(get_global_position())
	if ($MenuMensagem.position.x+250) > 320:
		
		print(b)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
