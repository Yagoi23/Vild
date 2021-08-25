extends Node

var Max_Health = 100
var Health = 100

var Apply_Knockback = false

var Max_Stamina = 100
var Stamina = 100

var attack_power = 10
var attacking = false

var Enemy_Sense = false

var xp_needed = 0
var xp = 0

func _process(delta):
	xp_needed = int(round((Max_Health + Max_Stamina + attack_power)/2))
	xp = int(round(xp))
	if xp >= xp_needed:
		xp = 0
		Max_Health += 1
		Max_Stamina += 1
		attack_power += 1
		print("lvl up")
	if Health > Max_Health:
		Health = Max_Health
	if Stamina > Max_Stamina:
		Stamina = Max_Stamina

func _onready():
	Health = 100
	Max_Health = 100
	Stamina = 100
	Max_Stamina = 100

func hit_player(ammount):
	Apply_Knockback = true
	Health -= ammount



