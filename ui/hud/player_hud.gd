extends CanvasLayer
export (String) var level_name = "level1"

func _ready():
	level_name = get_parent().scene_name
	$"%HighScore".text = str(ScoreTracker.high_score[level_name])
	ScoreTracker.reset_score_tracker()
	$"%Multiplier".text = "x" + str(ScoreTracker.score_multiplier)
	$"%CurrentScore".text = str(ScoreTracker.current_score)
	ScoreTracker.connect("score_changed", self, "update_scores")
	ScoreTracker.connect("multiplier_changed", self, "update_multiplier")
	
func update_scores():
	ScoreTracker.update_high_score(level_name)
	$"%HighScore".text = str(ScoreTracker.high_score[level_name])
	$"%CurrentScore".text = str(ScoreTracker.current_score)
	
func update_multiplier():
	$"%Multiplier".text = "x" + str(ScoreTracker.score_multiplier)
	
func activate_buff_icon(icon_name: String):
	$"%Void".visible = false
	$"%Jump".visible = false
	$"%Bomb".visible = false
	match icon_name:
		"void":
			$"%Void".visible = true
		"jump":
			$"%Jump".visible = true
		"bomb":
			$"%Bomb".visible = true

func deactivate_buff_icons():
	$"%Void".visible = false
	$"%Jump".visible = false
	$"%Bomb".visible = false
			
func activate_special_icons(icon_name: String):
	match icon_name:
		"time":
			$"%Time".visible = true
		"bonus":
			$"%Bonus".visible = true

func deactivate_special_icons(icon_name: String):
	match icon_name:
		"time":
			$"%Time".visible = false
		"bonus":
			$"%Bonus".visible = false
