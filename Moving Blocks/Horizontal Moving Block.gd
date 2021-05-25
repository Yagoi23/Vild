extends KinematicBody2D

const SPEED = 10

var velocity = Vector2()

var dir = 1

func _physics_process(delta):
	velocity.x = SPEED * dir
	velocity = move_and_slide(velocity)
	if is_on_wall():
		dir = dir * -1
