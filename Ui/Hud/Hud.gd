extends Control

func _ready():
	pass

func _process(delta):
	$HealthBar.value = PlayerStats.Health
