extends KinematicBody2D

var olhando = [false, "indefinido"]

func _on_Bumper_body_entered(body):
	olhando = [true,str(body.get_name())]
	print(body.get_name())


func _on_Bumper_body_exited(_body):
	olhando = [false,"indefinido"]




func _on_KinematicBody2D_Loaded():
	if get_node("../KinematicBody2D").eventos["principal"] >= 3:
		$".".set_position(Vector2(227,-48))
	else:
		$".".set_position(Vector2(167,-219))
