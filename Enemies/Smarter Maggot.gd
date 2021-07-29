extends KinematicBody2D

const GRAVITY = 100
const SPEED = 5
const FLOOR = Vector2(0,-1)

var follow_player


#var player = null
onready var SPRITE = $Sprite

var velocity = Vector2()

var dir = 1

func _physics_process(delta):
	if follow_player == true:
		for node in get_tree().get_nodes_in_group("Player"):
			#dir = (node.global_position.x - global_position.x)#.normalized()
			var t = (node.global_position.x - global_position.x)#.normalized()
			if t < 0:
				dir = -1
			elif t > 0:
				dir = 1
	velocity.x = SPEED * dir
	$AnimationPlayer.play("Maggot Crawl")
	velocity.y = GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	if is_on_wall():
		dir = dir * -1
		$RayCast2D.position *= -1
	if $RayCast2D.is_colliding() == false:
		dir = dir * -1
		$RayCast2D.position *= -1

func _process(delta):
	if PlayerStats.Enemy_Sense == true:
		SPRITE.modulate = Color(255,0,0) # turn sprite red
	else:
		SPRITE.modulate = Color(255,255,255) # turn sprite white

func _on_DetectionZone_area_entered(area):
	if area.is_in_group("Player"):
		follow_player = true


func _on_DetectionZone_area_exited(area):
	if area.is_in_group("Player"):
		follow_player = false


func _on_HitZone_area_entered(area):
	if area.is_in_group("Player"):
		PlayerStats.hit_player(10)
