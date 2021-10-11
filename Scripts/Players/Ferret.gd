extends Player
var tornadocd = false

func _input(_event):
	if Input.is_action_just_pressed("attack"+str(joystick_id)) and not rooted and not frozen and not in_action:
		if is_on_floor():
			if Input.is_action_pressed("left"+str(joystick_id)) or Input.is_action_pressed("right"+str(joystick_id)):
				
				$stabby.play("stab")
			if Input.is_action_pressed("up"+str(joystick_id)):
				$stabby.play("stabup")
			elif Input.is_action_pressed("down"+str(joystick_id)):
				$stabby.play("stabdown")
		elif not is_on_floor():
			if $spinny.is_playing() == false:
				$spinny.play("spin")
# Called when the node enters the scene tree for the first time.
	if Input.is_action_just_pressed("special"+str(joystick_id)) and not frozen and not in_action:
		if Input.is_action_pressed("up"+str(joystick_id)) or Input.is_action_pressed("down"+str(joystick_id)):
			
			if not tornadocd:
				var tornado = preload("res://Scripts/Abilities/tornado_ferret.tscn").instance()
				tornadocd = true
				get_parent().add_child(tornado)
				tornado.position = $tornadopos.get_global_position()
				var t = Timer.new()
				t.set_wait_time(4)
				t.set_one_shot(true)
				add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()
				tornadocd = false
		
#		elif Input.is_action_pressed("left"+str(joystick_id)) or Input.is_action_pressed("right"+str(joystick_id)):
		else:
			$tail.knockup = 25
			$tail.knockside = 25
			var knife = load("res://Scripts/Projectiles/Knife.tscn").instance()

			if facing == "left":
				knife.set("flight_direction", "left")
				knife.apply_scale(Vector2(-1, 1))
			elif facing == "right":
				knife.set("flight_direction", "right")
			knife.sentid = joystick_id
			knife.set("position", get_node("knifepos").get_global_position())
			get_parent().add_child(knife)
			var t = Timer.new()
			$AnimationPlayer.play("idle")
			t.set_wait_time(0.3)
			t.set_one_shot(true)
			rooted = true
			frozen = true
			add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			rooted = false
			var y = Timer.new()
			y.set_wait_time(0.3)

			y.set_one_shot(true)
			add_child(y)
			y.start()
			yield(y, "timeout")
			y.queue_free()
			frozen = false
			
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
