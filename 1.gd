extends TextureProgress


func _physics_process(delta):
	$".".set_value(get_node("../HSlider2").get_value())
