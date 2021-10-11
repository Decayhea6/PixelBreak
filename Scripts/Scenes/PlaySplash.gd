extends Control

func _ready():
	vars.contrunthrough = 0
	vars.controllers = []
	vars.winner = ""
	vars.char_paths = {}
	vars.arena_path = ""
	vars.current_controller = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	vars.alive_players = []
func _input(event):
	for controller in Input.get_connected_joypads():
		if Input.get_action_strength("shield"+str(controller)) > 0  and vars.controllers.has(controller) == false:
			vars.controllers.append(controller)
	if Input.get_action_strength("attack") > 0 or Input.get_action_strength("special") > 0 :
		if vars.controllers != []:
			vars.current_controller = vars.controllers[0]
#			print(vars.controllers)
			get_tree().change_scene("res://Scripts/Scenes/Main Menu.tscn")
func _process(delta):
	
#	vars.controllers = Input.get_connected_joypads()
	var controllersconnected = 0
	for i in vars.controllers:
		controllersconnected += 1
	var controllercount = 0
	for i in Input.get_connected_joypads():
		controllercount += 1
	$Label.set("text", str(controllersconnected) + "/" + str(controllercount) + " Controllers Connected (X)")
