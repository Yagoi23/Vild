extends Node2D


func _enter_tree():
	if Checkpoint.dead == true:
		if Checkpoint.last_position:
			$Player.global_position = Checkpoint.last_position
			Checkpoint.dead = false
	elif Checkpoint.exit_door_cords != null:
		$Player.global_position = Checkpoint.exit_door_cords
