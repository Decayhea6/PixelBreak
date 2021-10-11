extends Node2D
export var arena_scene = ""
export var music_file = ""
var animations = ["Mountain", "Default", "Beach", "Swamp"]
var musics = ["Spirit Tracks", "Star Wolf",  "Hidden Village","Bubblegum", "Gerudo Valley", "Gourmet Rush", "Sweden", "Danse Macambre", "Megalovania", "Palladio", "He's a Pirate", "Lily's Theme", "Golden Wind","K.K. Japan",  "Crab Rave", "Quartet 4", "No Music"]
var runthrough = -1
var runnum = -1
func _input(event):
	if Input.is_action_just_pressed("attack"):
		vars.arena_path = arena_scene
		vars.music_path = music_file
		print(music_file)
		print(arena_scene)
		get_tree().change_scene(vars.arena_path)
	elif Input.is_action_just_pressed("menu_left") and $Response.is_playing()==false:
		runthrough -= 1
		if runthrough < 0:
			runthrough = animations.size() - 1
		$AnimationPlayer.play(animations[runthrough])
		$Response.play("JumpStage")
	elif Input.is_action_just_pressed("menu_right") and $Response.is_playing()==false:
		runthrough += 1
		if runthrough == animations.size():
			runthrough = 0
		$AnimationPlayer.play(animations[runthrough])
		$Response.play("JumpStage")
	elif Input.is_action_just_pressed("menu_up") and $Response.is_playing()==false:
		runnum += 1
		if runnum == musics.size():
			runnum = 0
		
		$AnimationPlayer.play(musics[runnum])
		$Response.play("JumpMusic")
	elif Input.is_action_just_pressed("menu_down") and $Response.is_playing()==false:
		runnum -= 1
		if runnum < 0:
			runnum = musics.size() - 1

		$AnimationPlayer.play(musics[runnum])
		$Response.play("JumpMusic")
