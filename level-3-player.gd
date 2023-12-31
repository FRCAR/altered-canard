extends CharacterBody2D

const MOVE_SPEED = 400.0
const JUMP_VELOCITY = -600.0
const ANGEL_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var alive = true

signal lost
signal reset
signal won

func _ready():
	$PlayerArea.body_entered.connect(walk_in)

func _physics_process(delta):
	# Add the gravity.
	
	if alive : 
		if not is_on_floor() :
			velocity.y += gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump()
			
		if position.y  > 100 :
			lose()
	else : 
		if Input.is_action_just_pressed("attack") :
			reset.emit()
		else :
			velocity.y = ANGEL_VELOCITY
			
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * MOVE_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVE_SPEED)
	move_and_slide()

func walk_in(body):
	if body.get_meta("SpriteType") == "Spike" :
		lose()
	if body.get_meta("SpriteType") == "Enemy" :
		lose()
	if body.get_meta("SpriteType") == "Flag" :
		win()
		
func jump():
	velocity.y = JUMP_VELOCITY
	
func lose():
	if not alive :
		return
	alive = false
	$HitSound.play()
	$Sprite2D.hide()
	$AngelSprite.show()
	$AngelSprite.play("default")
	$CollisionShapePlayer.set_deferred("disabled", true)
	lost.emit()
	
func win():
	won.emit()
