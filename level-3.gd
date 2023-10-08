extends Node2D

signal player_won

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.update_life_point("Pas \nde \npoint \nde \nvie \nici")
	$HUD/GameOverLabel.set_text("Perdu : appuyez sur espace pour recommencer !")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_3_player_lost():
	$HUD.display_game_over()
	$HUD/GameOverAnim.hide()


func _on_level_3_player_won():
	$HUD.display_level_end()
	await get_tree().create_timer(5.0).timeout
	player_won.emit()


func _on_level_3_player_reset():
	get_tree().reload_current_scene()
