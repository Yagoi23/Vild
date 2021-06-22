extends KinematicBody2D

const GRAVITY = 100
const SPEED = -10
const FLOOR = Vector2(0,-1)

var velocity = Vector2()

var dir = 1

var counter = 0

enum state {MOVING, SHOOTING, DEPLOYINGGUN, UNDEPLOYINGGUN}
var snailboss_state = state.MOVING

func _physics_process(delta):
	if snailboss_state == state.MOVING:
		counter += 1
		if counter >= 60:
			counter = 0
			snailboss_state = state.DEPLOYINGGUN
		$AnimationPlayer.play("SnailBossMove")
		velocity.x = SPEED * dir
		#$AnimationPlayer.play("Maggot Crawl")
		velocity.y = GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
		if is_on_wall():
			if $Sprite.flip_h == true:
				$Sprite.flip_h = false
			elif $Sprite.flip_h == false:
				$Sprite.flip_h = true
			dir = dir * -1
	elif snailboss_state == state.DEPLOYINGGUN:
		$AnimationPlayer.play("SnailBossDeployGun")
		counter += 1
		if counter >= 60:
			counter = 0
			snailboss_state = state.SHOOTING
	elif snailboss_state == state.UNDEPLOYINGGUN:
		$AnimationPlayer.play_backwards("SnailBossDeployGun")
		counter += 1
		if counter >= 60:
			counter = 0
			snailboss_state = state.MOVING
	elif snailboss_state == state.SHOOTING:
		$AnimationPlayer.play("SnailBossShoot")
		counter += 1
		if counter >= 60:
			counter = 0
			snailboss_state = state.UNDEPLOYINGGUN
