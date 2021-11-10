extends Control

func _ready():
	pass

func _process(delta):
	$HealthBar.value = PlayerStats.Health #constently changes the max and current health value so it increases when the player increases it through a skill
	$HealthBar.max_value = PlayerStats.Max_Health
	$StaminaBar.value = PlayerStats.Stamina
	$ExpBar.value = PlayerStats.xp
	if PlayerStats.Max_Stamina <= 500:
		$StaminaBar.rect_size.x = 100 + PlayerStats.Max_Stamina #scales the stamina bar size with the players stamina
	else:
		$StaminaBar.rect_size.x = 500 #sets the stamina bar to a default size to avoid any errors
	if PlayerStats.Health <= 500:
		$HealthBar.rect_size.x = 100 + PlayerStats.Max_Health #works the same as with the stamina bar
	else:
		$HealthBar.rect_size.x = 500
	#$HealthBar.rect_size.x = 100 + PlayerStats.Max_Health
	$StaminaBar.max_value = PlayerStats.Max_Stamina
	$Label.text = str(PlayerStats.Max_Health) + "/" + str(PlayerStats.Max_Stamina) + "/" + str(PlayerStats.attack_power)
