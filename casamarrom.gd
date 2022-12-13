extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
var showCasaMarrom = "default"


# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	var check = $"../KinematicBody2D".position
	if check.x >= 21 and check.x <= 107 and check.y <= 166 and check.y >= 80:
		
		if check.y < 165:
			$AnimatedSprite.play("0")
			showCasaMarrom = $AnimatedSprite.get_animation()
		if check.y < 164:
			$AnimatedSprite.play("1")
			showCasaMarrom = $AnimatedSprite.get_animation()
		if check.y < 163:
			$AnimatedSprite.play("2")
			showCasaMarrom = $AnimatedSprite.get_animation()
			$Sprite.set_visible(true)
		if check.y < 162:
			$AnimatedSprite.play("3")
			showCasaMarrom = $AnimatedSprite.get_animation()
		if check.y < 161:
			$AnimatedSprite.play("4")
			showCasaMarrom = $AnimatedSprite.get_animation()
		if check.y < 160:
			$AnimatedSprite.play("5")
			showCasaMarrom = $AnimatedSprite.get_animation()
	else:
		$AnimatedSprite.play("default")
		showCasaMarrom = $AnimatedSprite.get_animation()
		$Sprite.set_visible(false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
