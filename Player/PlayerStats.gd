extends Node

var Max_Health = 100
var Health = 100

var Apply_Knockback = false

var Max_Stamina = 100
var Stamina = 100

var attack_power = 10
var attacking = false

var Enemy_Sense = false

var xp = 0

func _process(delta):
	if xp >= 100:
		xp = 0
		Max_Health += 10
		Max_Stamina += 10
		attack_power += 1

func _onready():
	Health = 100
	Max_Health = 100
	Stamina = 100
	Max_Stamina = 100

func hit_player(ammount):
	Apply_Knockback = true
	Health -= ammount



