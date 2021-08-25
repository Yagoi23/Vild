extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewGame_pressed():
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


func _on_LoadGame_pressed():
	SaveSystem.load_data()
	Checkpoint.dead = true
	get_tree().change_scene(Checkpoint.last_level)
	
