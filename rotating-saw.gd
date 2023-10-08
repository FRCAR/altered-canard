extends RigidBody2D

# in radians per seconds
const ROTATION_SPEED =  PI 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(delta * ROTATION_SPEED)
