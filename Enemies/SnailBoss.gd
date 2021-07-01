extends KinematicBody2D

const GRAVITY = 100
const SPEED = -15
const FLOOR = Vector2(0,-1)

var velocity = Vector2()

var dir = 1

var counter = 0
onready var SPRITE = $Sprite
#onready var MUZZLEFLASH = $MuzzleFlash
onready var BULLET_PARTICLE = $Bullets
onready var RAYCAST = $RayCast2D
onready var ANIMATIONPLAYER = $AnimationPlayer
enum state {MOVING, SHOOTING, DEPLOYINGGUN, UNDEPLOYINGGUN, ROLLING}
var snailboss_state = state.MOVING

func _ready():
	BULLET_PARTICLE.emitting = false

func _physics_process(delta):
	if dir == -1:
		SPRITE.flip_h = true
		BULLET_PARTICLE.position.x *= -1
		#MUZZLEFLASH.position.x *= -1
		#MUZZLEFLASH.flip_h == false
	elif dir == 1:
		SPRITE.flip_h = false
		BULLET_PARTICLE.position.x *= 1
		#MUZZLEFLASH.position.x *= 1
		#MUZZLEFLASH.flip_h == true
	if snailboss_state == state.MOVING:
		for node in get_tree().get_nodes_in_group("Player"):
			#dir = (node.global_position.x - global_position.x)#.normalized()
			var t = (node.global_position.x - global_position.x)#.normalized()
			if t < 0:
				dir = 1
			elif t > 0:
				dir = -1
		counter += 1
		if counter >= 120:
			counter = 0
			snailboss_state = state.DEPLOYINGGUN
		ANIMATIONPLAYER.play("SnailBossMove")
		velocity.x = SPEED * dir
		#$AnimationPlayer.play("Maggot Crawl")
		velocity.y = GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
		if is_on_wall():
			if SPRITE.flip_h == true:
				SPRITE.flip_h = false
			elif SPRITE.flip_h == false:
				SPRITE.flip_h = true
			dir = dir * -1
			BULLET_PARTICLE.position.x *= -1
			#M000LEFLASH.position.x *= -1
			#if MUZZLEFLASH.flip_h == true:
			#	MUZZLEFLASH.flip_h = false
			#elif MUZZLEFLASH.flip_h == false:
			#	MUZZLEFLASH.flip_h = true
	elif snailboss_state == state.DEPLOYINGGUN:
		ANIMATIONPLAYER.play("SnailBossDeployGun")
		counter += 1
		if counter >= 60:
			counter = 0
			snailboss_state = state.SHOOTING
	elif snailboss_state == state.UNDEPLOYINGGUN:
		ANIMATIONPLAYER.play_backwards("SnailBossDeployGun")
		counter += 1
		if counter >= 60:
			counter = 0
			snailboss_state = state.MOVING
	elif snailboss_state == state.SHOOTING:
		BULLET_PARTICLE.emitting = true
		ANIMATIONPLAYER.play("SnailBossShoot")
		counter += 1
		#if MUZZLEFLASH.visible == false:
		#	MUZZLEFLASH.visible = true
		#elif MUZZLEFLASH.visible == true:
		#	MUZZLEFLASH.visible = false
		check_collision()
		if counter >= 60:
			counter = 0
			BULLET_PARTICLE.emitting = false
			snailboss_state = state.UNDEPLOYINGGUN
	elif snailboss_state == state.ROLLING:
		
		pass

func check_collision():
	var collider = RAYCAST.get_collider()
	#print(collider.name)
	if collider:
		if collider.is_in_group("Player"):
			PlayerStats.hit_player(12)
			#collider.hit_enemy()
			print("Hit " + collider.name)
