extends Area2D
var can_travel = false
func _ready():
	$ArrowDown.visible = false
	

func _process(delta):
	if can_travel == true and Input.is_action_just_pressed("w"):
		print("travelled")
		get_tree().change_scene("res://Levels/Ruinous Road/Level2.tscn")#level the player is going to
		#Checkpoint.door_exit_cords = Checkpoint.starting_level_exit
		Checkpoint.exit_door_cords = Vector2(1584, 760) #coordinate player exits at




func _on_To_Level_1_area_exited(area):
	if area.is_in_group("Player"):
		can_travel = false #makes the indicator visible and allows the player to travel
		print("no")
		$ArrowDown.visible = false


func _on_To_Level_1_area_entered(area): #makes the indicator invisible and allows the player to not travel
	if area.is_in_group("Player"):
		can_travel = true
		print("yes")
		$ArrowDown.visible = true
	#pass # Replace with function body.
