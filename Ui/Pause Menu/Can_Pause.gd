extends Node

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if Pause.pause == false:
			get_tree().paused = true
			Pause.pause = true
		elif Pause.pause == true:
			get_tree().paused = false
			Pause.pause = false
