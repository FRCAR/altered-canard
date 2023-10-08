extends CharacterBody2D

const WALK_SPEED = 200
const JUMP_SPEED = 200
const GRAVITY = 200

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	
	var walkSpeed = WALK_SPEED * Input.get_axis("move_left", "move_right")
	velocity.x = walkSpeed
	
	velocity.y += gravity * delta

	move_and_slide()

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED
