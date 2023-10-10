extends CharacterBody2D

const MIN_SPEED = 200.0
const MAX_SPEED = 400.0
const JUMP_VELOCITY = -400.0
const SQUARE_SPRITE_SIZE = 18
var score = 3
var speed = MIN_SPEED
var x_player_initial = 0.0
var x_initial = 0.0
var direction = 1
signal killed

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	score = randi_range(10, 2000)
	var i = randi_range(1,5)
	var texture = load("res://img/hedgehog-enemy/" + str(i) + ".png")
	$Sprite2D.texture = texture

func set_x_player_initial(x_player) :
	x_player_initial = x_player
	x_initial = position.x
	
func set_direction(new_direction) :
	direction = new_direction

func _physics_process(delta):
	# Add the gravity.
	pass

func replace_on_x(x_player) :
	position.x = x_initial + direction *  (x_player - x_player_initial)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func hit():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
	killed.emit(position, score)
