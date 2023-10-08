extends Node2D

@export var orb_scene: PackedScene
@export var enemy_scene: PackedScene
@export var boar_scene: PackedScene

signal player_won

func _process(delta):
	if $FlameTransform.visible :
		$FlameTransform.position = $Player/Camera2D.get_screen_center_position()
	$HUD.update_life_point($Player.get_life_point())

# Called when the node enters the scene tree for the first time.
func _ready():
	$BoarGenerationTimer.start()
	$EnemyGenerationTimer.start()


func _on_boar_killed(enemyPosition, score):
	var orb = orb_scene.instantiate()
	orb.position = enemyPosition
	add_child(orb)
	$HUD.add_score(score)
	
func _on_enemy_killed(enemyPosition, score):
	$HUD.add_score(score)

func _on_enemy_generation_timer_timeout():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2($Player.position)
	enemy.position.x += 700
	enemy.killed.connect(_on_enemy_killed)
	add_child(enemy)

	

func _on_player_transformed():
	$FlameTransform.position = $Player/Camera2D.get_screen_center_position()
	$FlameTransform.start()
	#get_tree().paused = true
	#await get_tree().create_timer(1.0).timeout
	#get_tree().paused = false


func _on_player_lost():
	$HUD.display_game_over()
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene()


func _on_boar_generation_timer_timeout():
	var boar = boar_scene.instantiate()
	boar.position = Vector2($Player.position)
	boar.position.x += 800
	boar.killed.connect(_on_boar_killed)
	add_child(boar)


func _on_boss_1_killed():
	$HUD.display_level_end()
	await get_tree().create_timer(5.0).timeout
	player_won.emit()
