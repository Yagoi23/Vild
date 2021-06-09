extends Area2D

var can_travel = false

func _process(delta):
	if can_travel == true and Input.is_action_just_pressed("w"):
		print("travelled")

func _on_Area2D_body_entered(body):
	can_travel = true
	print("yes")
	#pass # Replace with function body.


func _on_Area2D_body_exited(body):
	can_travel = false
	print("no")
	#pass # Replace with function body.
