extends Node2D
var isready = false

func _ready():
		var char_name = ""
		if vars.char_paths[vars.alive_players[0]][0] == "res://Scripts/Players/Knight.tscn":
			char_name = "knight"
		elif vars.char_paths[vars.alive_players[0]][0] == "res://Scripts/Players/Necromancer.tscn":
			char_name = "pyromancer"
		elif vars.char_paths[vars.alive_players[0]][0] == "res://Scripts/Players/Ferret.tscn":
			char_name = "ferret"
		elif vars.char_paths[vars.alive_players[0]][0] == "res://Scripts/Players/Twiggy.tscn":
			char_name = "twiggy"
		$playerscenes.play(char_name)
		$AnimationPlayer.play(vars.char_paths[vars.alive_players[0]][2])
#	controllerid:	vars.char_paths[vars.alive_players[0]][1]
		var y = Timer.new()
		y.set_wait_time(3)
		y.set_one_shot(true)
		add_child(y)
		y.start()
		yield(y, "timeout")
		y.queue_free()
		get_tree().paused = true
		$AnimationPlayer.play("Transition In")
		var t = Timer.new()
		t.set_wait_time(2)
		t.set_one_shot(true)
		add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()

		isready=true
func _input(_event):
	if isready:
		if Input.is_action_just_pressed("attack"+str(vars.char_paths[vars.alive_players[0]][1])) or Input.is_action_just_pressed("special"+str(vars.char_paths[vars.alive_players[0]][1])):
			var y = Timer.new()
			$AnimationPlayer.play_backwards("Transition In")
		
			y.set_wait_time(0.6)
			y.set_one_shot(true)
			add_child(y)
			y.start()
			yield(y, "timeout")
			y.queue_free()
			get_tree().paused = false
			MenuTheme.playing = true
			get_tree().change_scene("res://Scripts/Scenes/ArenaSelect.tscn")
			vars.alive_players = []
		elif Input.is_action_just_pressed("shield"+str(vars.char_paths[vars.alive_players[0]][1])):
			var y = Timer.new()
			$AnimationPlayer.play_backwards("Transition In")
			y.set_wait_time(0.6)
			y.set_one_shot(true)
			add_child(y)
			y.start()
			yield(y, "timeout")
			y.queue_free()
			get_tree().paused = false
			MenuTheme.playing = true
			get_tree().change_scene("res://Scripts/Scenes/PlaySplash.tscn")	
			vars.alive_players = []
		elif Input.is_action_just_pressed("jump"+str(vars.char_paths[vars.alive_players[0]][1])):
			pass
