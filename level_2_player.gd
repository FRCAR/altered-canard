extends CharacterBody2D

const MOVE_SPEED = 300.0
const ROLL_SPEED = 300000.0
const JUMP_VELOCITY = -400.0
const MAX_POWER = 5
const MIN_LIFE_POINT = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var life_point = 3
var rolling = false
var speed = MOVE_SPEED

signal lost
signal ring

func _ready():
	$PlayerArea.body_entered.connect(walk_in)

func _physics_process(delta):
	
	
	# Add the gravity.
	if not is_on_floor() :
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
		
	var should_roll = false
	if Input.is_action_pressed("crouch") and is_on_floor():
		should_roll = true
		
	if not rolling and should_roll :
		start_rolling()
	if rolling and not should_roll :
		stop_rolling()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()
	if not rolling :
		if velocity.x != 0 or velocity.y != 0 :
			$AnimatedSprite2D.play("move")
		else :
			$AnimatedSprite2D.play("idle")
	
func get_life_point():
	return life_point

func walk_in(body):
	if body.get_meta("SpriteType") == "Enemy" :
		life_point -= 1
		if life_point < MIN_LIFE_POINT :
			lost.emit()
		return
	if body.get_meta("SpriteType") == "Ring" :
		ring.emit()
		body.consume()

func attack_on(body):
	if body.get_meta("SpriteType") == "Enemy" :
		body.hit()
		
func jump():
	velocity.y = JUMP_VELOCITY
	
func start_rolling():
	rolling = true
	speed = ROLL_SPEED
	$AnimatedSprite2D.play("roll")

func stop_rolling():
	rolling = false
	speed = MOVE_SPEED

