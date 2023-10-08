extends CanvasLayer

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
