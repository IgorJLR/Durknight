extends Area2D

var terreno = "deserto"
# var b = "text"
var cidade = ""

# Called when the node enters the scene tree for the first tim



func _on_Area2D2_body_entered(body):
	terreno = str(body.get_name())
	






func _on_Bumper_area_entered(area):
	cidade = str(area.get_name())
	print("foi dfg ",area.get_name())
	
	if area.get_name() == "Caverna" and get_node("../KinematicBody2D").eventos["principal"] >= 6 and get_node("../KinematicBody2D").eventos["principal"] < 8:
		get_node("../KinematicBody2D").cutscene = true
		get_node("../KinematicBody2D").batalha = true
		get_node("../KinematicBody2D/FundoBatalha").set_visible(true)
		get_node("../KinematicBody2D/FundoBatalha").play("Caverna")
