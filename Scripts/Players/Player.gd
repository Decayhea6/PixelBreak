extends KinematicBody2D
class_name Player
export var in_action = false
var joystick_id = 0
var movements = 0
export var weapon_connect_sfx=""
export var hit_sfx=""
export var armour = 0
export var invuln = 0.5
export var vuln = 0.3
var wasonfloor = true
export var speed = Vector2(300.0, 700.0)
export var gravity = 3000.0
export var rooted = false
export var frozen = false
export var life = 100
export var invulnurable = false
export var death_scene = "pyromancer"
var color = ""
export var jumps = 4
var type = "player"
var velocity: = Vector2.ZERO
export var dash_velocity = Vector2.ZERO
var prevdir = Vector2.ZERO
var facing = ("right")
var knockedback = false
var trail = preload("res://Scripts/Items/Color Trail.tscn").instance() 
var deatheffects = preload("res://Scripts/Items/DeathEffects.tscn").instance()
func _ready():
	
	frozen = false
	rooted = false
	invulnurable = false
	dash_velocity =  Vector2.ZERO
	$Bleeding.set("emitting", false)
	$Bleeding.get_node("AnimationPlayer").play(color)
	vars.char_paths[joystick_id].append(life)
	$LifeBar.set("player_id", joystick_id)
	$LifeBar.get_node("AnimationPlayer").play(color)
	add_child(trail)
	trail.get_node("AnimationPlayer").play(color)
	trail.set("emitting", false)
func _physics_process(delta):
	
#		movements = jumps
	
		
	if not frozen:
		if get_direction().x != 0 or get_direction().y < 0:
			trail.set("emitting", true)
			#$Indicator.hide()
		else:
			trail.set("emitting", false)
		if Input.is_action_just_pressed("attack"+str(joystick_id)) and not in_action:
#			$AnimatedSprite.play("Idle")
			if Input.get_action_strength("right"+str(joystick_id)) > 0 or Input.get_action_strength("left"+str(joystick_id)) > 0:
				$AnimationPlayer.set("current_animation", "ForwardAttack")
			elif Input.get_action_strength("up"+str(joystick_id)) > 0:
				$AnimationPlayer.set("current_animation", "TopAttack")
			elif Input.get_action_strength("down"+str(joystick_id)) > 0:
				$AnimationPlayer.set("current_animation", "DownAttack")
			else:
				$AnimationPlayer.set("current_animation", "NeutralAttack")
#		elif Input.get_action_strength("special"+str(joystick_id)) == 0:
		if Input.get_action_strength("right"+str(joystick_id)) - Input.get_action_strength("left"+str(joystick_id)) != 0 and is_on_floor():
			$AnimatedSprite.set("animation", "run")
		elif is_on_floor() and ($AnimatedSprite.animation != "jump") and ($AnimatedSprite.animation !="land"):
			$AnimatedSprite.set("animation", "idle")
			
###On Death THings.
	if vars.char_paths[joystick_id][3] <= 0:
		print("dead")
#		call("death")
		get_parent().add_child(deatheffects)
		deatheffects.set("position", self.get_global_position())
		deatheffects.get_node("AnimationPlayer").play(color)
		deatheffects.set("emitting", true)
		vars.alive_players.erase(joystick_id)
		print(vars.alive_players)
		queue_free()
#		self.get_tree().get_root().get_node("Arena").end_game()
	var is_jump_interrupted: = Input.is_action_just_released("jump"+str(joystick_id)) and velocity.y < 0.0
	var direction: = get_direction()

	if not knockedback:
		velocity = calculate_move_velocity(is_jump_interrupted, velocity, direction, speed)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	if frozen or rooted:
		if facing == "left":
			dash_velocity.x = dash_velocity.x * -1
		move_and_slide(dash_velocity, Vector2.UP)
	if direction.x != 0: #set the direction of the body based on mvmnt
		if direction.x > 0 and prevdir.x <= 0 and facing == "left" and not frozen and not rooted and not in_action:
			facing = "right"
			apply_scale(Vector2( -1, 1))
			prevdir = direction
		elif direction.x < 0 and prevdir.x >= 0 and facing == "right" and not frozen and not rooted and not in_action:
			facing = "left" 
			trail.get_node("AnimationPlayer")
			apply_scale(Vector2( -1, 1))
			prevdir = direction
	if wasonfloor == false and is_on_floor() == true:
		movements = jumps
		$AnimatedSprite.play("land")
	wasonfloor = is_on_floor()
func get_direction() -> Vector2:
	var diry = 0
	var dirx = Input.get_action_strength("right" + str(joystick_id)) - Input.get_action_strength("left" + str(joystick_id))
	if rooted or frozen:
		dirx = 0
	
	if Input.is_action_just_pressed("jump"+str(joystick_id)) and not rooted and not frozen and movements > 0:
		movements -= 1
		diry = -1.0
		$AnimatedSprite.frame = 0
		$AnimatedSprite.play("jump")
		
	
#	elif not frozen:
#		diry = 1.0
	
	return Vector2(dirx,diry)

func calculate_move_velocity(
	is_jump_interrupted: bool,
	linear_velocity: Vector2, 
	direction: Vector2, 
	speed: Vector2

) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y < 0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0
	if rooted:
		new_velocity = Vector2.ZERO
	return new_velocity
	
func knockback(angle: Vector2, damage: int, time: float):
	if not invulnurable:
		$AnimationPlayer.play("None")
		$Bleeding.set("emitting", true)
		Input.start_joy_vibration(joystick_id, 1, 1, 0.2)
	##set up a new timer to count the time of the air smash
		var t = Timer.new()
		t.set_wait_time(time)
		t.set_one_shot(true)
		self.add_child(t)
		knockedback = true
		frozen = true
		###what happens when you get hit
		var dmg = damage - armour
		if damage - armour <= 0:
			dmg = 0
		vars.char_paths[joystick_id][3] = vars.char_paths[joystick_id][3]-dmg
#		print(life)
		velocity = (angle)
		#####
		#wait x seconds and then stop     
		t.start()
		yield(t, "timeout")
		t.queue_free()
		######
		frozen = false                              
		knockedback = false
		$Bleeding.set("emitting", false)
	
	
func _input(event: InputEvent) -> void:
	if not in_action:
		if Input.is_action_just_pressed("shield"+str(joystick_id)) and not frozen:
			$AnimatedSprite.play("dodge")
			rooted = true
			frozen = true
			invulnurable = true
			var t = Timer.new()
			t.set_wait_time(invuln)
			t.set_one_shot(true)
			add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			invulnurable = false
			$AnimatedSprite.play("idle")
			rooted = false
			var t2 = Timer.new()
			t2.set_wait_time(vuln)
			t2.set_one_shot(true)
			add_child(t2)
			add_child(t2)
			t2.start()
			yield(t2, "timeout")
			t2.queue_free()
			frozen = false
			invulnurable = false
			t2.queue_free()
#			knockback(Vector2(1000, -500), 3, 0.1)
### Change The Animation--- Remember To Name Them All "idle", and "run"                                                                                                                                                                                                                                                           
