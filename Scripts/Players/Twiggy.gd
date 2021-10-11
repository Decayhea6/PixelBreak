extends Player

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("special"+str(joystick_id)) and not frozen and not in_action:
		
		if Input.is_action_pressed("down"+str(joystick_id)):
			$AnimationPlayer.play("Eat")
			var y = Timer.new()
			y.set_wait_time(3)
			y.set_one_shot(true)
			add_child(y)
			y.start()
			yield(y, "timeout")
			y.queue_free()
			if frozen and $AnimationPlayer.current_animation == "Eat":
				vars.char_paths[joystick_id][3] = vars.char_paths[joystick_id][3]+20
			if vars.char_paths[joystick_id][3] > life:
				vars.char_paths[joystick_id][3] = life
		elif Input.is_action_pressed("up"+str(joystick_id)):
			$AnimationPlayer.play("Spite")
			var y = Timer.new()
			y.set_wait_time(2)
			y.set_one_shot(true)
			add_child(y)
			y.start()
			yield(y, "timeout")
			y.queue_free()
			if frozen and $AnimationPlayer.current_animation == "Spite":
				var spitel2 = load("res://Scripts/Projectiles/SpiteFruit.tscn").instance()
				var spitel1 = load("res://Scripts/Projectiles/SpiteFruit.tscn").instance()
				var spitem = load("res://Scripts/Projectiles/SpiteFruit.tscn").instance()
				var spiter1 = load("res://Scripts/Projectiles/SpiteFruit.tscn").instance()
				var spiter2 = load("res://Scripts/Projectiles/SpiteFruit.tscn").instance()
				get_parent().add_child(spitel2)
				get_parent().add_child(spitel1)
				get_parent().add_child(spitem)
				get_parent().add_child(spiter1)
				get_parent().add_child(spiter2)
				spitel2.position = $l2.get_global_position()
				spitel1.position = $l1.get_global_position()
				spitem.position = $m.get_global_position()
				spiter1.position = $r1.get_global_position()
				spiter2.position = $r2.get_global_position()
		else:
			var apple = load("res://Scripts/Projectiles/Fruit.tscn").instance()

			var directionlr = Input.get_action_strength("right"+str(joystick_id))-Input.get_action_strength("left"+str(joystick_id))
			apple.linear_velocity = Vector2(350*directionlr, -70)
			if directionlr < 0:
				apple.get_node("AnimationPlayer").play("spinleft")
				apple.angular_velocity = 0
			else:
				apple.angular_velocity = 0
				apple.get_node("AnimationPlayer").play("spinright")
			apple.set("position", get_node("ApplePosition").get_global_position())
			get_parent().add_child(apple)
			frozen = true
			
			var t = Timer.new()
			t.set_wait_time(0.4)
			t.set_one_shot(true)
			add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			frozen = false
				
				
