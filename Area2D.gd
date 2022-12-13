extends Area2D

var terreno = "campo"
# var b = "text"
var cidade = ""

# Called when the node enters the scene tree for the first tim



func _on_Area2D2_body_entered(body):
	terreno = str(body.get_name())
	






func _on_Bumper_area_entered(area):
	cidade = str(area.get_name())
	print("foi dfg ",area.get_name())
	if cidade != "Blocker" and cidade != "Blocker2" and cidade != "Blocker3" and cidade != "Blocker4" and not "loot" in cidade and area.get_name() != "Caverna" and area.get_name() != "gelo trap":
		get_node("../KinematicBody2D").go(cidade)
