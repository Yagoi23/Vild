extends Area2D #
var can_travel = false #presets the variable can travel to false

func _ready():
	$ArrowDown.visible = false #premakes the arrow invisible

func _process(delta):
	if can_travel == true and Input.is_action_just_pressed("w"): #when the player pushes the w key
		print("travelled")#prints travelled
		Checkpoint.exit_door_cords = Vector2(32, 131) #sets the exit door coordinates to the coordinates the player needs to show up at
		get_tree().change_scene("res://Levels/Ruinous Road/Level2.tscn") #
		#Checkpoint.starting_level_exit = global_position

func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		can_travel = true
		print("yes")
		$ArrowDown.visible = true
	#pass # Replace with function body.


func _on_Area2D_area_exited(area):
	if area.is_in_group("Player"):#hides everything and makes it so the variable can player travel is false
		can_travel = false
		print("no")
		$ArrowDown.visible = false
