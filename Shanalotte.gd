extends KinematicBody2D


export (int) var speed = 200
var velocity = Vector2()
var movendo = false
var movimento = 0
var direcao = 0
var timer = 10
var olhando = [false, "indefinido"]
var off = false



func _on_Bumper_body_entered(body):
	olhando = [true,str(body.get_name())]
	print(body.get_name())


func _on_Bumper_body_exited(_body):
	olhando = [false,"indefinido"]




func _on_personagemdserto_Loaded():
	if get_node("../personagemdserto").eventos["principal"] <= 7:
		$".".set_position(Vector2(-73,2))
	else:
		$".".set_position(Vector2(-172,-146))
