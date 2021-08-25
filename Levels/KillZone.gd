extends Area2D




func _on_KillZone_area_entered(area):
	if area.is_in_group("Player"):
		get_tree().reload_current_scene()
