extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.update_life_point("Pas \nde \npoint \nde \nvie \nici")
	$HUD.set_intro_screen("titre-4-4")
	
	get_tree().call_group("br-enemies", "set_x_player_initial", $Player.position.x)
	$Enemy.set_direction(-1)
	$Enemy2.set_direction(-1)
	$Enemy3.set_direction(-1)
	$Enemy4.set_direction(-1)
	$Enemy5.set_direction(-1)
	
	$Enemy6.set_direction(-2)
	$Enemy7.set_direction(-2)
	$Enemy8.set_direction(-2)
	$Enemy9.set_direction(-2)
	
	$Enemy10.set_direction(1)
	$Enemy11.set_direction(1)
	$Enemy12.set_direction(1)
	$Enemy13.set_direction(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_tree().call_group("br-enemies", "replace_on_x", $Player.position.x)


func _on_player_lost():
	get_tree().change_scene_to_file("res://end.tscn")


func _on_player_won():
	get_tree().change_scene_to_file("res://end.tscn")
