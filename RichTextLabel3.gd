extends RichTextLabel

var alfa = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
var aux = 0
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_0timer_timeout():
	$"../0timer".start(get_node("../HSlider2").get_value()/1000)
	$".".set_text(alfa[aux])
	aux += 1
	if aux == 26:
		aux = 0
