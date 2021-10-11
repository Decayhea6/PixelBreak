extends Weapon


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
			var t = Timer.new()
			t.set_wait_time(2)
			t.set_one_shot(true)
			add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
