extends Node2D



var go = 0
var gogo = false
var t = 0.01
var d = 126
var timers = 0


func _ready():
	$grilos.play()

func _physics_process(delta):
	if $WorldEnvironment.environment.get_adjustment_brightness() < 1:
		t += 0.01
		$WorldEnvironment.environment.set_adjustment_brightness(t)
	if go == 0:
		$Sprite.scale += Vector2(0.00001,0.00001) * delta
	if go == 0:
		yield(get_tree().create_timer(10), "timeout")
	$Sprite.set_visible(false)
	if go == 0:
		yield(get_tree().create_timer(5), "timeout")
	if go == 0:
		$AnimatedSprite2.play("default")
		$rei.play()
	
	if go == 0:
		
		yield( get_node("AnimatedSprite2"), "animation_finished" )
		if $AnimatedSprite2.get_animation() != "sai":
			go = 1
			$AnimatedSprite3.set_visible(true)
			$AnimatedSprite.play("morrer1")
			
		
	if $AnimatedSprite3.position.x > -87 and go == 1:
		d = $AnimatedSprite3.get_position()
		$AnimatedSprite3.set_position(d - Vector2(10,0))
	else:
		finalizar()
	if go == 2 and $WorldEnvironment.environment.get_adjustment_saturation() > 0.05:
			t -= 0.01
			$WorldEnvironment.environment.set_adjustment_saturation(t)
	else:
		if go == 2:
			go = 3
		if go == 3 and $RichTextLabel.rect_position.y > -352:
			$RichTextLabel.rect_position.y -= 0.1
		if go == 3 and $RichTextLabel.rect_position.y <= -352:
			go = 4
			get_tree().change_scene("res://Cidade Principal.tscn")
			queue_free()

func finalizar():
	if gogo == false and go != 4:
		gogo = true
		$AnimatedSprite.stop()
		$AnimatedSprite.set_animation("morre2")
		$AnimatedSprite.play("morre2")
		$AnimatedSprite.set_frame(0)
		$AnimatedSprite.play("morre2")
		$AnimatedSprite.set_animation("morre2")
		$AnimatedSprite.play("morre2")
		$AnimatedSprite.set_frame(0)
		$AnimatedSprite2.play("sai")
		$AnimatedSprite3.set_visible(false)
		$music.play()
		t = 1
		yield(get_tree().create_timer(2), "timeout")
		go = 2
		
