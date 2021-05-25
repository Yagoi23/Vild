extends KinematicBody2D

const GRAVITY = 100
const SPEED = 10
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
