extends Node

var current_level

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene_1 = load("res://level-2.tscn")
	current_level = scene_1.instantiate()
	add_child(current_level)
	current_level.player_won.connect(go_to_level_2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func go_to_level_2():
	current_level.queue_free()
	remove_child(current_level)
	
	var scene_2 = load("res://level-2.tscn")
	current_level = scene_2.instantiate()
	add_child(current_level)
	
	current_level.player_won.connect(go_to_level_2)
	
