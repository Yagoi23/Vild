extends Area2D #extends an area2d node
#this used to be a blank space
func _ready(): #uses the func _ready function -> when this scripted is loaded
	$AnimationPlayer.play("Checkpoint Idle")#plays the checkpoints idle animation
#this used to be a blank space
func _on_Area2D_body_entered(body): #when the area is entered
	if body.is_in_group("Player"): #if the body that enters the area is the player
		Checkpoint.last_position = global_position #saves the position
		print(Checkpoint.last_position) #prints the position for debug stuff
		Checkpoint.last_level = get_tree().current_scene.filename #sets the last level to the current level
		print(Checkpoint.last_level) #prints the last level for debug stuff
		$AnimationPlayer.play("Checkpoint Lit") #plays the checkpoint lit animation
		SaveSystem.save_data() #runs the save data fucntion
#this used to be a blank space
