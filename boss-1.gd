extends CharacterBody2D

const SPEED = 0.0
const JUMP_VELOCITY = -300.0
var direction = -1
var score = 10_000_000
var life_point = 5
signal killed

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if is_on_floor() :
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# velocity.x = direction * SPEED

	move_and_slide()
	
	if position.y < -750 :
		position.y = -250
	
func hit():
	life_point -= 1
	if life_point == 0 : 
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()
		killed.emit()
