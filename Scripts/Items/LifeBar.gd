extends TextureProgress
var player_id = 0
func _ready() -> void:
	max_value = get_parent().get("life")
	min_value = 0
func _process(delta):
	value = vars.char_paths[player_id][3]
#	print (vars.char_paths[player_id][3])
