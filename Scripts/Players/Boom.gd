extends Area2D
class_name NonDirectionalWeapon
export var damage = 5
export var air_time = 0.1
export var knockback_scale = 40
export var maxknockback = Vector2(100, 100)
func _ready():
	self.connect("body_entered",self,"hits_player")
	pass

func hits_player(bodyname):
	if bodyname.get("type") == "player" or bodyname.get("type") == "item":
		if bodyname != self.get_parent():
			var direction = bodyname.get_global_position() - self.get_global_position()
			bodyname.knockback((direction)*knockback_scale, damage, air_time)
