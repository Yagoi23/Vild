extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.Max_Health = 1000
	PlayerStats.Health = 1000
	PlayerStats.Max_Stamina = 10
	PlayerStats.stat_points = 10
	PlayerStats.attack_power = 10
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ExitTutorial_area_entered(area):
	if area.is_in_group("Player"):
		get_tree().change_scene("res://Levels/Ruinous Road/Starting Level.tscn")
		PlayerStats.Max_Health = 10
		PlayerStats.Max_Stamina = 10
		PlayerStats.attack_power = 1
		PlayerStats.Health = 10
		PlayerStats.Stamina = 10
		PlayerStats.stat_points = 0
		PlayerStats.xp = 0
		PlayerStats.gold = 10
		PlayerStats.attacking = false
