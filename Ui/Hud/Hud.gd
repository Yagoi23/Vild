extends Control

func _ready():
	pass

func _process(delta):
	$HealthBar.value = PlayerStats.Health
	$HealthBar.max_value = PlayerStats.Max_Health
	$StaminaBar.value = PlayerStats.Stamina
	$StaminaBar.max_value = PlayerStats.Max_Stamina
	$Label.text = str(PlayerStats.Max_Health) + "/" + str(PlayerStats.Max_Stamina)
