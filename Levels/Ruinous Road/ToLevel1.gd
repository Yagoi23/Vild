extends Area2D
var can_travel = false
func _ready():
	$ArrowDown.visible = false
	

func _process(delta):
	if can_travel == true and Input.is_action_just_pressed("w"):
		print("travelled")
		get_tree().change_scene("res://Levels/Ruinous Road/Starting Level.tscn")
		#Checkpoint.door_exit_cords = Checkpoint.starting_level_exit
		Checkpoint.exit_door_cords = Vector2(688, 352)




func _on_To_Level_1_area_exited(area):
	if area.is_in_group("Player"):
		can_travel = false
		print("no")
		$ArrowDown.visible = false


func _on_To_Level_1_area_entered(area):
	if area.is_in_group("Player"):
		can_travel = true
		print("yes")
		$ArrowDown.visible = true
	#pass # Replace with function body.
