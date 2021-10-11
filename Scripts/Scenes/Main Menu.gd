extends Control
export var char_scene = ""
export var color = ""
export var animations = ["Pyromancer", "Rose"]

var runnum = -1
var runthrough = -1

func _process(delta):
	$Label.set("text", "Controller " + str(vars.current_controller+1) + " ("+ color + ") Is Currently Selecting")
func _ready():
	
	vars.colors.shuffle()
	print(vars.contrunthrough)
	print(vars.current_controller)

	$AnimationPlayer.play("None")
	Input.start_joy_vibration(vars.current_controller, 1, 1, 1)
func _input(event):
	if Input.is_action_just_pressed("menuleft" + str(vars.current_controller)):
		
		runthrough -= 1
		if runthrough < 0:
			runthrough = animations.size() - 1
		$AnimationPlayer.play(animations[runthrough])
		$Thread2.stop()
		$Thread2.play("Jump")
	if Input.is_action_just_pressed("menuright"+str(vars.current_controller)):
		runthrough += 1
		if runthrough == animations.size():
			runthrough = 0
		$AnimationPlayer.play(animations[runthrough])
		$Thread2.stop()
		$Thread2.play("Jump")

	if Input.is_action_just_pressed("menudown" + str(vars.current_controller)):
		if $AnimationPlayer.is_playing() == false:
			runnum -= 1
			if runnum < 0:
				runnum = vars.colors.size() - 1
			$AnimationPlayer.play(vars.colors[runnum])
	if Input.is_action_just_pressed("menuup"+str(vars.current_controller)):
		if $AnimationPlayer.is_playing() == false:
			runnum += 1
			if runnum == vars.colors.size():
				runnum = 0
			$AnimationPlayer.play(vars.colors[runnum])
	if Input.is_action_just_pressed("attack"+str(vars.current_controller)) or Input.is_action_just_pressed("special" + str(vars.current_controller)):
		if char_scene != "" and color != "":
			vars.colors.erase(color)
			vars.char_paths[vars.current_controller] = [char_scene, vars.current_controller, color]
	
			if vars.current_controller == vars.controllers[-1]:
#				print("all chars selecte
				get_tree().change_scene("res://Scripts/Scenes/ArenaSelect.tscn")
				print(vars.alive_players)
			else:
				vars.contrunthrough += 1
				vars.current_controller = vars.controllers[vars.contrunthrough]
				get_tree().reload_current_scene()

	#			get_tree().change_scene(vars.arena_path)
				#the char paths are stored: controller id: charachter path, controller id
