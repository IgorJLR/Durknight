extends TextureProgress


func _physics_process(delta):
	$".".set_value(get_node("../HSlider").get_value())
	AudioServer.set_bus_volume_db(0,get_node("../HSlider").get_value() -94)
