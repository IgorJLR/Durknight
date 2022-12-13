extends RigidBody2D


var olhando = [false, "indefinido"]
var vazio = false
var loot = ["Capacete Escuro","Poção de Vida Pequena", "Poção de Mana Pequena"]



func _on_Bumper_body_entered(body):
	olhando = [true, str(body.get_name())]


func _on_Bumper_body_exited(_body):
	olhando = [false,"indefinido"]


func _on_KinematicBody2D_BauVazio(pointer):
	if pointer == "bau real":
		$AnimatedSprite.play("abrir")
		vazio = true


func _on_KinematicBody2D_Loaded():
	if get_node("../KinematicBody2D").eventos["loot"]["bau real"] == false:
		vazio = true
		$AnimatedSprite.play("aberto")
