extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#pass


func _on_KinematicBody2D_Loaded():
	if get_node("../KinematicBody2D").eventos["principal"] > 11:
		set_visible(true)
		$".".set_position(Vector2(0,0))
