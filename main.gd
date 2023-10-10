extends Node

var current_level

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = load("res://level-4-1.tscn")
	current_level = scene.instantiate()
	add_child(current_level)
	get_tree().set_current_scene(current_level)
	current_level.player_won.connect(go_to_level_4_2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func go_to_level_2():
	current_level.queue_free()
	remove_child(current_level)
	
	var scene_2 = load("res://level-2.tscn")
	current_level = scene_2.instantiate()
	add_child(current_level)
	
	current_level.player_won.connect(go_to_level_3)
	
	
func go_to_level_3():
	current_level.queue_free()
	remove_child(current_level)
	
	var scene_3 = load("res://level-3.tscn")
	current_level = scene_3.instantiate()
	add_child(current_level)
	
	current_level.player_won.connect(go_to_level_4_1)


func go_to_level_4_1():
	current_level.queue_free()
	remove_child(current_level)
	
	var scene = load("res://level-4-1.tscn")
	current_level = scene.instantiate()
	add_child(current_level)
	
	current_level.player_won.connect(go_to_level_4_2)
	
func go_to_level_4_2():
	current_level.queue_free()
	remove_child(current_level)
	
	var scene = load("res://level-4-2.tscn")
	current_level = scene.instantiate()
	get_tree().set_current_scene(current_level)
	add_child(current_level)
	
	current_level.player_won.connect(go_to_level_4_2)
