extends Node2D

func _enter_tree():
	PlayerStats.attacking = false #stops a bug
	if Checkpoint.dead == true:
		if Checkpoint.last_position:#if player died set them to the checkpoint
			$Player.global_position = Checkpoint.last_position
			Checkpoint.dead = false
			PlayerStats.attacking = false
	elif Checkpoint.exit_door_cords != null:
		$Player.global_position = Checkpoint.exit_door_cords #if player went through a door go to the exit point
	#else:
	#	$Player.global_position =  Checkpoint.door_exit_cords

