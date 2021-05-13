extends Control

func _process(delta):
	$Label.text = str(PlayerMovement.MOVE_SPEED)
