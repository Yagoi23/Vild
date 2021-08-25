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
	get_tree().change_scene("res://Levels/Tutorial.tscn")
	PlayerStats.attacking = false


func _on_LoadGame_pressed():
	SaveSystem.load_data()
	Checkpoint.dead = true
	get_tree().change_scene(Checkpoint.last_level)
	
