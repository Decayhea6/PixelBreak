extends KinematicBody2D
class_name Item
export var gravity = 3000.0
export var life = 100
var type = "item"
var velocity: = Vector2.ZERO
func _physics_process(delta: float) -> void:
	move_and_slide(velocity, Vector2.UP)
	
func knockback(angle: Vector2, damage: int, time: float):
	##set up a new timer to count the time of the air smash
	var t = Timer.new()
	t.set_wait_time(time)
	t.set_one_shot(true)
	self.add_child(t)
	###what happens when you get hit
	life = life-damage
	print(life)
	velocity = (angle)
	#####
	#wait x seconds and then stop     
	t.start()
	yield(t, "timeout")
	t.queue_free()
	######     
     