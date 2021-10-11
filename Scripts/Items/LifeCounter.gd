extends Label
var player_id = 0
var maxlife = 0
func _ready():
	$AnimationPlayer.play(vars.char_paths[player_id][2])
	maxlife = vars.lifetotals[player_id]
func _process(delta):
	var percentage = float(vars.lifetotals[player_id] / maxlife) #* 100
	print (percentage)
	set("text", str(percentage) + "%")
	if vars.lifetotals[player_id] <= 0:
		queue_free()
