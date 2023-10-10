extends CanvasLayer

var score = 0
var show_intro_screen = true
var intro_screen_file_name = ""

signal hidden

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if show_intro_screen and Input.is_action_pressed("attack"):
		hide_intro_screen()
		hidden.emit()

func update_life_point(life_point):
	$HeartBarValue.text = str(life_point)

func display_game_over():
	$GameOverAnim.visible = true
	$GameOverLabel.visible = true
	$GameOverAnim.play("default")
	
func add_score(score_delta):
	score += score_delta
	$Score.text = str(score)

func display_level_end():
	$NextLevelAnim.visible = true
	$NextLevelLabel.visible = true
	$NextLevelAnim	.play("default")

func hide_intro_screen():
	$IntroScreen.hide()
	show_intro_screen = false
	
func set_intro_screen(file_name) :
	intro_screen_file_name = file_name
	var texture = load("res://img/intro-screen/" + intro_screen_file_name + ".png")
	$IntroScreen.texture = texture
