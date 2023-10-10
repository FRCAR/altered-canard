extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.update_life_point("Pas \nde \npoint \nde \nvie \nici")
	$HUD.set_intro_screen("titre-4-2")
	$Enemy.set_x_player_initial($Player.position.x)
	$Enemy.set_direction(-1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Enemy : 
		$Enemy.replace_on_x($Player.position.x)


func _on_player_lost():
	$HUD.display_game_over()
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene()


func _on_player_won():
	get_tree().change_scene_to_file("res://level-4-3.tscn")
