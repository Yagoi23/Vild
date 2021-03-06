extends KinematicBody2D

const GRAVITY = 100
const SPEED = 5
const FLOOR = Vector2(0,-1)

var velocity = Vector2()

var dir = 1

onready var SPRITE = $Sprite

func _physics_process(delta): #makes maggot crawl and not fall off things
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

func _on_HitZone_area_entered(area): #hits the player
	if area.is_in_group("Player"):
		PlayerStats.hit_player(10)
		PlayerStats.Apply_Knockback = true

var health = rand_range(1,10)
var player_can_hit = false
onready var BLOOD_PARTICLE = $Blood
func _process(delta):
	#if PlayerStats.Enemy_Sense == true:
	#	SPRITE.modulate = Color(255,0,0) # turn sprite red
	#	#EnemySenseLight.enabled = true
	#else:
	#	SPRITE.modulate = Color(255,255,255) # turn sprite white
		#EnemySenseLight.enabled = false
	
	if player_can_hit == true and PlayerStats.attacking == true: #gets hit by player
		health -= PlayerStats.attack_power
		BLOOD_PARTICLE.emitting = true
	else:
		BLOOD_PARTICLE.emitting
	if health <= 0: #dies
		PlayerStats.xp += rand_range(1,10)
		queue_free()

func _on_Area2D_area_entered(area): #allows player to attack
	if area.is_in_group("Player_Attack"):
		player_can_hit = true


func _on_Area2D_area_exited(area): #disallows player to attack
	if area.is_in_group("Player_Attack"):
		player_can_hit = false
