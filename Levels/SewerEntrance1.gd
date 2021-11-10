extends Area2D
#old code
var can_travel = false

func _process(delta):
	if can_travel == true and Input.is_action_just_pressed("w"):
		print("travelled")
		get_tree().change_scene("res://Levels/TheNachoRoom.tscn")

func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		can_travel = true #makes the indicator visible and allows the player to travel
		print("yes")
	#pass # Replace with function body.


func _on_Area2D_area_exited(area):
	if area.is_in_group("Player"):
		can_travel = false
		print("no")
	#pass # Replace with function body.
