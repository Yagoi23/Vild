extends KinematicBody2D

const GRAVITY = 100
const SPEED = 10
const FLOOR = Vector2(0,-1)

var velocity = Vector2()

var dir = 1

var health = rand_range(1,1000)
var player_can_hit = false

onready var BLOOD_PARTICLE = $Blood

func _process(delta):
	#if PlayerStats.Enemy_Sense == true:
	#	SPRITE.modulate = Color(255,0,0) # turn sprite red
		#EnemySenseLight.enabled = true
	#else:
	#	SPRITE.modulate = Color(255,255,255) # turn sprite white
		#EnemySenseLight.enabled = false
	
	if player_can_hit == true and PlayerStats.attacking == true: #if the player can hit this enemy and the player is attacking
		health -= PlayerStats.attack_power
		BLOOD_PARTICLE.emitting = true
	else:
		BLOOD_PARTICLE.emitting = false
	if health <= 0: #deletes the enemy when it doesn't have any health
		PlayerStats.xp += rand_range(1,10)
		queue_free()

onready var SPRITE = $Sprite #preloads sprite

func _physics_process(delta): #makes the enemy move
	velocity.x = SPEED * dir
	$AnimationPlayer.play("Maggot Crawl")
	velocity.y = GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	if is_on_wall(): #changes direction when touching a wall
		dir = dir * -1


func _on_Area2D_area_entered(area): #sets it so the player can hit it and destroys it if its touching a spike
	if area.is_in_group("Player_Attack"):
		player_can_hit = true
	if area.is_in_group("Hazard"):
		queue_free()


func _on_Area2D_area_exited(area): #sets player attack to faLSE
	if area.is_in_group("Player_Attack"):
		player_can_hit = false


func _on_HitZone_area_entered(area):
	if area.is_in_group("Player"): #hits the player
		PlayerStats.hit_player(10)
		PlayerStats.Apply_Knockback = true
