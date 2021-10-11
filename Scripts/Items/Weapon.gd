extends Area2D
class_name Weapon
export var knockup = 500
export var knockside = 900
export var damage = 2
export var air_time = 0.1 #in seconds
var type = "item"
func _ready():
	self.connect("body_entered",self,"hits_player")
	pass

func hits_player(bodyname):
	if bodyname.get("type") == "player" or bodyname.get("type") == "item":
		if bodyname != self.get_parent():
			
			if self.get_parent().get("facing") == "left":
				bodyname.knockback(Vector2(knockside * -1 , knockup * -1), damage, air_time) 
			else:
				bodyname.knockback(Vector2(knockside , knockup * -1), damage, air_time)
