extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_POWER = 5
const MIN_LIFE_POINT = -2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var life_point = 3
var attacking = false
var attack_cooldown = false
var power = 1
var jumping = false
var player_transformed = false

signal transformed
signal lost

func _ready():
	$FistArea.hide()
	$PlayerArea.body_entered.connect(walk_in)
	get_node("FistArea/CollisionShapeFist").disabled = true
	get_node("FistArea").body_entered.connect(attack_on)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() :
		velocity.y += gravity * delta
		if jumping and velocity.y > 0 :
			velocity.y = 0

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
		
	# Handle parasite jump (power up)
	if power_up_makes_jump() and is_on_floor() :
		jump()
		
	if Input.is_action_just_pressed("crouch") and not is_on_floor():
		unjump()
		
	# Attack
	if Input.is_action_pressed("attack"):
		start_attack()

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
	
	
func get_life_point():
	return life_point
	
func start_attack():
	if(attacking or attack_cooldown):
		return
	attacking = true
	get_node("FistArea/CollisionShapeFist").disabled = false
	$FistArea.show()
	$AttackDuration.start()
	
func stop_attack():
	attacking = false
	get_node("FistArea/CollisionShapeFist").disabled = true
	$FistArea.hide()
	attack_cooldown = true
	$AttackCooldown.start()

func walk_in(body):
	if body.get_meta("SpriteType") == "Enemy" :
		life_point -= 1
		$HitSound.play()
		if life_point < MIN_LIFE_POINT :
			lost.emit()
		return
	if body.get_meta("SpriteType") == "Orb" :
		if power < MAX_POWER :
			scale *=1.4
			power += 1
		if power < MAX_POWER :
			$PowerUpSound.play()
		if power == MAX_POWER and not player_transformed :
			$TransformSound.play()
			transform()
		body.consume()

func attack_on(body):
	if body.get_meta("SpriteType") == "Enemy" :
		body.hit()
		$PunchSound.play()
		
func jump():
	velocity.y = JUMP_VELOCITY
	jumping = true
	
func unjump():
	jumping = false
	
func power_up_makes_jump():
	if power < 1 or power >= MAX_POWER :
		return false
	if power == 2 :
		return randf() < 0.0047619  #1.0/210
	if power == 3 :
		return randf() < 0.0111111 # 1.0/90
	if power == 4 :
		return randf() < 0.0166667 # 1.0/60
		
func transform():
	#Afficher la transformation (pause le jeu)
	# changer sprite du joueur
	# l'attaque détruit tout l'écran
	
	var random_image = randi_range(1,10)
	var texture = load("res://img/head/" + str(random_image) + ".png")
	$Head.texture = texture
	transformed.emit(random_image)
	player_transformed = true
	$FistArea.scale = Vector2(3,3)

func _on_attack_cooldown_timeout():
	attack_cooldown = false

func _on_attack_duration_timeout():
	stop_attack()
