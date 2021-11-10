extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		PlayerStats.stat_points += 100
		PlayerStats.gold += 100
	if Pause.pause == false: #makes the pause menu visible when the game is paused
		visible = false
	else:
		visible = true
	if PlayerStats.stat_points >= 1: #shows the little plus buttons
		$Stats/HP/HP_UP.visible = true
		$Stats/SP/SP_UP.visible = true
		$Stats/AP/AP_UP.visible = true
	else:
		$Stats/HP/HP_UP.visible = false
		$Stats/SP/SP_UP.visible = false
		$Stats/AP/AP_UP.visible = false
	
	$Stats/HP/Label.text = str(PlayerStats.Health) + "/" + str(PlayerStats.Max_Health) #updates the display of the playerrs current stats
	$Stats/SP/Label.text = str(PlayerStats.Stamina) + "/" + str(PlayerStats.Max_Stamina)
	$Stats/AP/Label.text = str(PlayerStats.attack_power)
	$Stats/XP/Label.text = str(PlayerStats.xp) + "/" + str(PlayerStats.xp_needed)
	$Stats/XP/XP_Bar.max_value = int(PlayerStats.xp_needed)
	$Stats/XP/XP_Bar.value = int(PlayerStats.xp)
	$Stats/PP/Label.text = str(PlayerStats.stat_points)
	$Stats/Gold/Label.text = str(PlayerStats.gold)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MainMenu_pressed(): #changes the scene to the main menu
	get_tree().change_scene("res://Ui/MainMenu/MainMenu.tscn")
	get_tree().paused = false
	Pause.pause = false


func _on_Quit_pressed(): #quits the game
	get_tree().quit()


func _on_HP_UP_pressed(): #increases the players hp
	PlayerStats.stat_points -= 1
	PlayerStats.Max_Health += 1
	PlayerStats.Health = PlayerStats.Max_Health


func _on_SP_UP_pressed(): #increases the players stamina
	PlayerStats.stat_points -= 1
	PlayerStats.Max_Stamina += 1
	PlayerStats.Stamina = PlayerStats.Max_Stamina


func _on_AP_UP_pressed():  #increases the players attack
	PlayerStats.stat_points -= 1
	PlayerStats.attack_power += 1
