extends Node2D


func _enter_tree():
	PlayerStats.attacking = false #stopos the player from attacking because the game has issues otherwise
	if Checkpoint.dead == true: 
		if Checkpoint.last_position:
			$Player.global_position = Checkpoint.last_position #moves the player to the checkpoint if they died
			#PlayerStats.attacking = false
			Checkpoint.dead = false 
	elif Checkpoint.exit_door_cords != null:
		$Player.global_position = Checkpoint.exit_door_cords #moves the player to the door exit coordinates if they exited a door
