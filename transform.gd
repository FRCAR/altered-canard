extends AnimatedSprite2D

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

func _on_transform_timer_timeout():
	var texture = load("res://img/boarhit.png")
	$Transformer.texture = texture


func _on_kill_timer_timeout():
	hide()
