extends Control

func _process(delta):
	$Label.text = str(PlayerMovement.player_state)
