extends Node

var Max_Health = 100
var Health = 100

var Apply_Knockback = false

var Max_Stamina = 100
var Stamina

func _onready():
	Health = 100

func hit_player(ammount):
	Apply_Knockback = true
