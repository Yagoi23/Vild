extends KinematicBody2D

const GRAVITY = 100
const SPEED = 10
const FLOOR = Vector2(0,-1)

var velocity = Vector2()

var dir = 1

var health = rand_range(1,1000)
var player_can_hit = false

func _process(delta):
	if PlayerStats.Enemy_Sense == true:
		SPRITE.modulate = Color(255,0,0) # turn sprite red
		#EnemySenseLight.enabled = true
	else:
		SPRITE.modulate = Color(255,255,255) # turn sprite white
		#EnemySenseLight.enabled = false
	
	if player_can_hit == true and PlayerStats.attacking == true:
		health -= PlayerStats.attack_power
	
	if health <= 0:
		PlayerStats.xp += rand_range(1,10)
		queue_free()

onready var SPRITE = $Sprite

func _physics_process(delta):
	velocity.x = SPEED * dir
	$AnimationPlayer.play("Maggot Crawl")
	velocity.y = GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	if is_on_wall():
		dir = dir * -1


func _on_Area2D_area_entered(area):
	if area.is_in_group("Player_Attack"):
		player_can_hit = true
	if area.is_in_group("Hazard"):
		queue_free()


func _on_Area2D_area_exited(area):
	if area.is_in_group("Player_Attack"):
		player_can_hit = false


func _on_HitZone_area_entered(area):
	if area.is_in_group("Player"):
		PlayerStats.hit_player(10)
		PlayerStats.Apply_Knockback = true
