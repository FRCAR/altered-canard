extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const SQUARE_SPRITE_SIZE = 18
var direction = -1
var score = 3
signal killed

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	score = randi_range(10, 2000)
	var i = randi_range(1,4)
	var texture = load("res://img/altered-enemy/" + str(i) + ".png")
	$Sprite2D.texture = texture
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if is_on_floor() and is_on_wall():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity.x = direction * SPEED

	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func hit():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
	killed.emit(position, score)
