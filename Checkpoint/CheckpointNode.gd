extends Area2D

func _ready():
	$AnimationPlayer.play("Checkpoint Idle")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		Checkpoint.last_position = global_position
		print(Checkpoint.last_position)
		Checkpoint.last_level = get_tree().current_scene.filename
		print(Checkpoint.last_level)
		$AnimationPlayer.play("Checkpoint Lit")
