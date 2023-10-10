extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MIN_LIFE_POINT = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal lost
signal won

func _ready():
	$PlayerArea.body_entered.connect(walk_in)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() :
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	if position.y  > 100 :
		lost.emit()

func walk_in(body):
	if body.get_meta("SpriteType") == "Spike" :
		$HitSound.play()
		lost.emit()
	if body.get_meta("SpriteType") == "Enemy" :
		if position.y + 32 < body.position.y :
			$PunchSound.play()
			body.hit()
			jump()
		else :
			$HitSound.play()
			lost.emit()
	if body.get_meta("SpriteType") == "Flag" :
		win()
		

func attack_on(body):
	if body.get_meta("SpriteType") == "Enemy" :
		body.hit()
		
func jump():
	velocity.y = JUMP_VELOCITY
	
func win():
	won.emit()
	
