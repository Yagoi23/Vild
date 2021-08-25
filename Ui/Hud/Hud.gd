extends Control

func _ready():
	pass

func _process(delta):
	$HealthBar.value = PlayerStats.Health
	$HealthBar.max_value = PlayerStats.Max_Health
	$StaminaBar.value = PlayerStats.Stamina
	$ExpBar.value = PlayerStats.xp
	if PlayerStats.Max_Stamina <= 500:
		$StaminaBar.rect_size.x = 100 + PlayerStats.Max_Stamina
	else:
		$StaminaBar.rect_size.x = 500
	if PlayerStats.Health <= 500:
		$HealthBar.rect_size.x = 100 + PlayerStats.Max_Health
	else:
		$HealthBar.rect_size.x = 500
	#$HealthBar.rect_size.x = 100 + PlayerStats.Max_Health
	$StaminaBar.max_value = PlayerStats.Max_Stamina
	$Label.text = str(PlayerStats.Max_Health) + "/" + str(PlayerStats.Max_Stamina) + "/" + str(PlayerStats.attack_power)
