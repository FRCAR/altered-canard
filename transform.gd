extends AnimatedSprite2D

var random_image = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func start():
	show()
	$TransformTimer.start()
	$KillTimer.start()

func set_random_image(i):
	random_image = i
	var texture = load("res://img/head/" + str(random_image) + ".png")
	$Transformer.texture = texture

func _on_transform_timer_timeout():
	$Transformer.show()


func _on_kill_timer_timeout():
	hide()
	$SuperMusic.play()
