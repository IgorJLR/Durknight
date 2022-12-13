extends Area2D

var vai = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if vai == 0:
		vai = 1
		$".".position += Vector2(100000,100000)
		yield(get_tree().create_timer(.1), "timeout")
		$".".position -= Vector2(100000,100000)
		yield(get_tree().create_timer(.1), "timeout")
		vai = 2
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	var terreno = str(body.get_name())
	


func _on_KinematicBody2D_terreno():
	if vai == 2:
		vai = 0
