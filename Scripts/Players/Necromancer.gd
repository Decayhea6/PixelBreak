extends Player
#basically this is the place to put all the specialized moves

func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("special"+str(joystick_id)) and not frozen and not in_action:
		var fireball = load("res://Scripts/Projectiles/Fireball.tscn").instance()
		var firefall = load("res://Scripts/Projectiles/Firefall.tscn").instance()
		if Input.get_action_strength("right"+str(joystick_id)) > 0 or Input.get_action_strength("left"+str(joystick_id))> 0:

			var t = Timer.new()
			t.set_wait_time(0.5)
			t.set_one_shot(true)
			frozen = true
			var directionlr = Input.get_action_strength("right"+str(joystick_id))-Input.get_action_strength("left"+str(joystick_id))
#			var directionup = Input.get_action_strength("up"+str(joystick_id)) * -0.4
#			fireball.set("tilt_y" , fireball.get("tilt_y") * directionup)
#			fireball.set("tilt_x", fireball.get("tilt_x") * directionlr)
			
#			if fireball.get("tilt_x") < 0.5 and fireball.get("tilt_x") > 0 :
#				fireball.set("tilt_x", 0.5)
#			elif fireball.get("tilt_x") < 0 and fireball.get("tilt_x") > -0.5 :
#				fireball.set("tilt_x", -0.5)
			get_parent().add_child(fireball)
			if directionlr < 0:
#				fireball.set("rotation_degrees", Input.get_action_strength("up"+str(joystick_id)) * 90)
				fireball.apply_scale(Vector2(-1, 1))
#			elif directionlr == 0:
#				fireball.set("rotation_degrees", -90)
#			else:
#				fireball.set("rotation_degrees", Input.get_action_strength("up"+str(joystick_id)) * -90
			if facing == "left":
				fireball.set("flight_direction", "left")
#				fireball.set("flight_direction", "left")
			elif facing == "right":
				fireball.set("flight_direction", "right")
			
			fireball.set("position", get_node("Position2D").get_global_position())
			add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			
			
			frozen = false
		elif Input.is_action_pressed("up"+str(joystick_id)) and not in_action:
			if movements > 0 and not frozen and not rooted:


				$AnimatedSprite.visible = false
				$LifeBar.visible = false
				frozen = true
				var sparks = preload("res://Sprites/Effects/tpbust.tscn").instance()
				movements -= 1
				
				get_parent().add_child(sparks)
				sparks.position = self.get("position")
				sparks.play("flamespin")
				var t = Timer.new()
				t.set_wait_time(0.5)
				t.set_one_shot(true)
				rooted = true
				frozen = true
				add_child(t)
				
				if not knockedback:
					t.start()
					yield(t, "timeout")
					t.queue_free()
					rooted = false
					var directional = Vector2(Input.get_action_strength("right"+str(joystick_id))-Input.get_action_strength("left"+str(joystick_id)), 0 - Input.get_action_strength("up"+str(joystick_id)))
					set("position", Vector2(get("position").x + 160 * directional.x, get("position").y + 160 * directional.y))
					
	#				print(move_and_collide(Vector2(0,-1)))
					
					var y = Timer.new()
					y.set_wait_time(0.3)
					
					y.set_one_shot(true)
					add_child(y)
					y.start()
					yield(y, "timeout")
					y.queue_free()
					frozen = false							
				rooted = false
				$AnimatedSprite.visible = true
				$LifeBar.visible = true
		elif Input.is_action_pressed("down"+str(joystick_id)) and not in_action:	
			
			var t = Timer.new()
			t.set_wait_time(0.5)
			t.set_one_shot(true)
			frozen = true
			if facing == "left":
				firefall.set("flight_direction", "left")
#				fireball.set("flight_direction", "left")
			elif facing == "right":
				firefall.set("flight_direction", "right")
			get_parent().add_child(firefall)
			firefall.set("position", Vector2(self.get_global_position().x, 0))
			add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			
			
			frozen = false
		elif not in_action:
			var sparks = load("res://Sprites/Effects/sparks.tscn").instance()
			$Boom.monitoring = true
			frozen = true
			rooted = true
			add_child(sparks)
			sparks.play("boom")
			var t = Timer.new()
			t.set_wait_time(0.2)
			t.set_one_shot(true)
	

			add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			$Boom.monitoring = false
			var y = Timer.new()
			y.set_wait_time(0.7)
			y.set_one_shot(true)
			add_child(y)
			y.start()
			yield(y, "timeout")
			y.queue_free()
			rooted = false
			frozen = false

