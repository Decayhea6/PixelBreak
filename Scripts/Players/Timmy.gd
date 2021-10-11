extends Player

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
#		if Input.get_action_strength("ui_up") < 0 and Input.get_action_strength("ui_down") < 0:
			$AnimatedSprite.stop()
			$AnimatedSprite.play("double_punch")
