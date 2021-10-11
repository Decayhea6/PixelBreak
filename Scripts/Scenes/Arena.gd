extends Node2D
class_name Arena
var musicplayer = preload("res://Music/AudioStreamPlayer.tscn").instance()
var winnerscreen = preload("res://Scripts/Items/WinnerScreen.tscn").instance()
var versus = true
func _ready():
	MenuTheme.playing = false
	versus = true
	if vars.music_path != "none":
		var music = load(vars.music_path)
		music.set_loop(true)
		
		musicplayer.stream = music
		add_child(musicplayer)
		
	for hero in vars.char_paths:
		var playerhero = load(vars.char_paths[hero][0]).instance()
		playerhero.set("color", vars.char_paths[hero][2]) 
		playerhero.set("joystick_id", vars.char_paths[hero][1])
		add_child(playerhero)
		playerhero.get_node("AnimationPlayer").play("None")
		playerhero.set("position", get_node("SpawnPoint"+str(hero+1)).get("position"))
		vars.char_paths[hero][3] = playerhero.get("life")
		vars.alive_players.append(vars.char_paths[hero][1]) 
		print(vars.alive_players.size())

	if vars.alive_players.size() == 1:
		versus = false
#		var counter = load("res://Scripts/Items/LifeCounter.tscn").instance()
#		counter.set("player_id", hero)
#		lifebox.add_child(counter)
func _process(_delta):
		if versus:
#		print("versus is on")
			if vars.alive_players.size() < 2:	

				add_child(winnerscreen)

			

