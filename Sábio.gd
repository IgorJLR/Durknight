extends KinematicBody2D

var olhando = [false, "indefinido"]
var dormindo = false
var mostrar = "default"

func _on_Bumper_body_entered(body):
	olhando = [true,str(body.get_name())]
	print(body.get_name())


func _on_Bumper_body_exited(_body):
	olhando = [false,"indefinido"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("../KinematicBody2D").eventos["npcs"]["Sábio"] == false:
		$AnimatedSprite.play("dormindo")
	else:
		
		$AnimatedSprite.play("Acordado")




func _on_KinematicBody2D_Loaded():
	if get_node("../KinematicBody2D").eventos["principal"] >= 3:
		queue_free()

