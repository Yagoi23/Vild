extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("MaggotMakerIdle")
	$Timer.start()

func _on_Timer_timeout():
	var node = load("res://Enemies/Maggot.tscn")
	var enemy = node.instance()
	enemy.position.x = 0
	enemy.position.y = 0
	add_child(enemy)
	
