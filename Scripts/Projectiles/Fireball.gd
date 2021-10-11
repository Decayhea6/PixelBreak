extends Area2D
class_name RangedAttack
export var tilt_x = 1.0
export var tilt_y = 0.0
export var projectile_speed = 300
export var flight_time = 1
export var knockup = 500
export var knockside = 900
export var damage = 2
export var air_time = 0.1
	 #in seconds
var sentid = 0
var motion = Vector2.ZERO
var flight_direction  = "right"

func _ready():
	self.connect("body_entered",self,"hits_player")
	self.connect("area_entered",self,"hits_shield")
	var t = Timer.new()
	t.set_wait_time(flight_time)
	t.set_one_shot(true)
	add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	self.free()

func _physics_process(delta):
#	motion = Vector2(tilt_x, tilt_y) * projectile_speed
	if flight_direction == "left":
		motion = Vector2(tilt_x  * -1, tilt_y) * projectile_speed
	elif flight_direction == "right":
		motion = Vector2(tilt_x, tilt_y) * projectile_speed
	self.set("position", self.get("position") + motion * delta)
	
func hits_player(bodyname):
#	print(bodyname)
	if bodyname.get("type") == "player" or bodyname.get("type") == "item":
		
		if flight_direction == "left":
			bodyname.knockback(Vector2(knockside * -1 , knockup * -1), damage, air_time) 
		elif flight_direction == "right":
			bodyname.knockback(Vector2(knockside , knockup * -1), damage, air_time)
	if bodyname.get("type") == "player" and bodyname.joystick_id == sentid:
		pass
	else:
		queue_free()
func hits_shield(bodyname):

	queue_free()
