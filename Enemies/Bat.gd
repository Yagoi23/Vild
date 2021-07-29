extends KinematicBody2D

#const GRAVITY = 100
const SPEED = 25
const FLOOR = Vector2(0,-1)

var follow_player

onready var SPRITE = $Sprite
onready var EnemySenseLight = $EnemySenseLight
#var player = null

var velocity = Vector2()

var x_dir = 1
var y_dir = 1

func _physics_process(delta):
	if follow_player == true:
		for node in get_tree().get_nodes_in_group("Player"):
			#dir = (node.global_position.x - global_position.x)#.normalized()
			var t = (node.global_position.x - global_position.x)#.normalized()
			if t < 0:
				x_dir = -1
				$Sprite.flip_h = true
			elif t > 0:
				x_dir = 1
				$Sprite.flip_h = false
			var k = (node.global_position.y - global_position.y)
			if k < 0:
				y_dir = -1
			elif k > 0:
				y_dir = 1
	velocity.x = SPEED * x_dir
	velocity.y = SPEED * y_dir
	
	$AnimationPlayer.play("Bat Fly")
	
	velocity = move_and_slide(velocity, FLOOR)

func _process(delta):
	if PlayerStats.Enemy_Sense == true:
		SPRITE.modulate = Color(255,0,0) # turn sprite red
		EnemySenseLight.enabled = true
	else:
		SPRITE.modulate = Color(255,255,255) # turn sprite white
		EnemySenseLight.enabled = false

func _on_DetectionZone_area_entered(area):
	if area.is_in_group("Player"):
		follow_player = true


func _on_DetectionZone_area_exited(area):
	if area.is_in_group("Player"):
		follow_player = false


func _on_HitZone_area_entered(area):
	if area.is_in_group("Player"):
		PlayerStats.hit_player(10)
		#collider.hit_enemy()
		#print("Hit " + collider.name)
