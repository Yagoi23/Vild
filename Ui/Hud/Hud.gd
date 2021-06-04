extends Control

func _process(delta):
	$Label.text = "hello"#str(PlayerMovement.state.keys()[PlayerMovement.player_state])
