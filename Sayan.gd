extends KinematicBody2D

var olhando = [false, "indefinido"]
var move = false

func _on_Bumper_body_entered(body):
	olhando = [true,str(body.get_name())]
	print(body.get_name())

func _physics_process(_delta):
	if move == true and get_node("../KinematicBody2D").eventos["principal"] == 3 and $".".get_position() < Vector2(7,-234):
		$".".move_and_slide(Vector2(+15,0))
		$AnimatedSprite.play("anda")
	else:
		$AnimatedSprite.play("default")

func _on_Bumper_body_exited(_body):
	olhando = [false,"indefinido"]


func _on_KinematicBody2D_Loaded():
	if get_node("../KinematicBody2D").eventos["principal"] >= 3:
		$".".set_position(Vector2(-33,-234))
		move = true
	else:
		$".".set_position(Vector2(374,91))

