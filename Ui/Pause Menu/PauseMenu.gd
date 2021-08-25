extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Pause.pause == false:
		visible = false
	else:
		visible = true
	$Stats/HP/Label.text = str(PlayerStats.Health) + "/" + str(PlayerStats.Max_Health)
	$Stats/SP/Label.text = str(PlayerStats.Stamina) + "/" + str(PlayerStats.Max_Stamina)
	$Stats/AP/Label.text = str(PlayerStats.attack_power)
	$Stats/XP/Label.text = str(PlayerStats.xp) + "/" + str(PlayerStats.xp_needed)
	$Stats/XP_Bar.max_value = PlayerStats.xp_needed
	$Stats/XP_Bar.value = PlayerStats.xp

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MainMenu_pressed():
	get_tree().change_scene("res://Ui/MainMenu/MainMenu.tscn")
	get_tree().paused = false
	Pause.pause = false


func _on_Quit_pressed():
	get_tree().quit()
