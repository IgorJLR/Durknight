extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
# Called when the node enters the scene tree for the first time.
	
func _physics_process(_delta):
	if $RichTextLabel.rect_position.y > -3163:
			$RichTextLabel.rect_position.y -= 0.5
	else:
		get_tree().change_scene("res://MenuPrincipal.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
