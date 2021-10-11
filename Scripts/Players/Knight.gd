extends Player

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("special"+str(joystick_id)) and not frozen and not in_action:
		if Input.is_action_pressed("right"+str(joystick_id)) or Input.is_action_pressed("left"+str(joystick_id)):
			if not rooted and movements > 0:
				$AnimationPlayer.play("dash_right")
		elif Input.is_action_pressed("down"+str(joystick_id)):
			$AnimationPlayer.play("Grab")
		elif Input.is_action_pressed("up"+str(joystick_id)):
			$AnimationPlayer.play("heal")
			var y = Timer.new()
			y.set_wait_time(2)
			y.set_one_shot(true)
			add_child(y)
			y.start()
			yield(y, "timeout")
			y.queue_free()
			if frozen and $AnimationPlayer.current_animation == "heal":
				vars.char_paths[joystick_id][3] = vars.char_paths[joystick_id][3]+9
			if vars.char_paths[joystick_id][3] > life:
				vars.char_paths[joystick_id][3] = life
		else:
			$AnimationPlayer.play("heartpierce")
