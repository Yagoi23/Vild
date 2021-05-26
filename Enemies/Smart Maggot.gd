extends KinematicBody2D

const GRAVITY = 100
const SPEED = 5
const FLOOR = Vector2(0,-1)

var velocity = Vector2()

var dir = 1

func _physics_process(delta):
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
