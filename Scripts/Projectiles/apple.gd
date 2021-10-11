extends Weapon

func _ready():
	if get_parent().linear_velocity.x < 0:
		knockside = knockside * -1
