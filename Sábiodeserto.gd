extends KinematicBody2D

var olhando = [false, "indefinido"]
var dormindo = false
var mostrar = "default"

func _on_Bumper_body_entered(body):
	olhando = [true,str(body.get_name())]
	print(body.get_name())


func _on_Bumper_body_exited(_body):
	olhando = [false,"indefinido"]

func _physics_process(_delta):
	mostrar = get_node("../vendinhadeserto").showCasaDeserto
	mostra()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func mostra():
	if mostrar != "default":
		$AnimatedSprite.set_visible(true)
		$AnimatedSprite.play("pensa")
	else:
		$AnimatedSprite.set_visible(false)






func _on_personagemdserto_Loaded():
	if get_node("../personagemdserto").eventos["principal"] >= 8:
		queue_free()
