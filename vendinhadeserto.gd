extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
var showCasaDeserto = "default"


# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	var check = $"../personagemdserto".position
	if check.x >= 29 and check.x <= 90 and check.y <= 155 and check.y >= 120:
		
		if check.y < 154:
			$AnimatedSprite.play("default")
			showCasaDeserto = $AnimatedSprite.get_animation()
		if check.y < 153:
			$AnimatedSprite.play("1")
			showCasaDeserto = $AnimatedSprite.get_animation()
		if check.y < 152:
			$AnimatedSprite.play("2")
			showCasaDeserto = $AnimatedSprite.get_animation()
			
		if check.y < 151:
			$AnimatedSprite.play("3")
			showCasaDeserto = $AnimatedSprite.get_animation()
		if check.y < 150:
			$AnimatedSprite.play("4")
			showCasaDeserto = $AnimatedSprite.get_animation()
		if check.y < 149:
			$AnimatedSprite.play("5")
			$Sprite.set_visible(true)
			showCasaDeserto = $AnimatedSprite.get_animation()
		else:
			$Sprite.set_visible(false)
	else:
		$AnimatedSprite.play("default")
		showCasaDeserto = $AnimatedSprite.get_animation()
		$Sprite.set_visible(false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
