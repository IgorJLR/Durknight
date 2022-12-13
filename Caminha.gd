extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if $".".is_playing() == false and get_node(".../personagemdserto").movendo == true:

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
