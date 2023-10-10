extends Node2D

@export var enemy_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.set_intro_screen("titre-2")
	
func start_level():
	$Enemy1GeneratorTimer.start()
	$Enemy2GeneratorTimer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HUD.update_life_point($Level2Player.get_life_point())

func _on_enemy_1_generator_timer_timeout():
	add_enemy()
	
func _on_enemy_2_generator_timer_timeout():
	add_enemy()
	
func add_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2($Level2Player.position)
	enemy.position.x += 700
	enemy.killed.connect(_on_enemy_killed)
	add_child(enemy)
	
func _on_enemy_killed(enemyPosition, score):
	$HUD.add_score(score)

func _on_level_2_player_lost():
	$HUD.display_game_over()
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene()


func _on_boss_2_killed():
	$HUD.display_level_end()
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://level-3.tscn")


func _on_hud_hidden():
	start_level()
