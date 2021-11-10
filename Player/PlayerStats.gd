extends Node
#sets base stats for the player
var Max_Health = 100
var Health = 100

var Apply_Knockback = false

var Max_Stamina = 100
var Stamina = 100

var attack_power = 10
var attacking = false

var Enemy_Sense = false

var stat_points = 0

var xp_needed = 0
var xp = 0

var gold = 0

var Lamp = false

func _process(delta): #handles xp
	xp_needed = int(round((Max_Health + Max_Stamina + attack_power)/2))
	xp = int(round(xp))
	if xp >= xp_needed:
		xp = 0
		stat_points += 1
		print("lvl up")
	if Health > Max_Health: #stops health and stamina getting higher then their max values
		Health = Max_Health
	if Stamina > Max_Stamina:
		Stamina = Max_Stamina

func _onready(): #sets base values
	Health = 100
	Max_Health = 100
	Stamina = 100
	Max_Stamina = 100

func hit_player(ammount): #allows for knocking the blayer back
	Apply_Knockback = true
	Health -= ammount



