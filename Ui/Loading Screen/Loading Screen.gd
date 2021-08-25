extends Control

var tips = ["You can move your Character horizontaly with A and D",
	"You can make your Character jump by pushing SPACE",
	"You can make your Character attack by LEFT CLICKING",
	"Your Character can jump in the air multiple times if you have enough SP",
	"Your Character only regenerates SP while standing on the ground",
	"When you upgrade your HP or SP they are refilled to their new value",
	"Getting hit will hit you into the air",
	"You can use PP to upgrade your HP SP and AP while paused",
	"You will earn PP when you fill up your XP",
	"When you level up your skills it increases the ammount of XP required to earn PP",
	"You can survive 1 hit from a maggot if you have 11 HP",
	"Maggots deal 10 damage",
	"You continuously gain speed whilst in the air",
	"Getting hit decreases your HP",
	"Jumping uses SP",
	"Get good",
	"Nacho Nick",
	"Did you find the Nacho",
	"Subscribe to LukeRS for quality content"]

func _ready():
	$Tips/Tips.text = str(tips[rand_range(0,14)])
	$Tips/Timer.start()


func _on_Timer_timeout():
	$Tips/Tips.text = str(tips[rand_range(0,19)])
