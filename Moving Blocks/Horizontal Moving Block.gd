extends KinematicBody2D

const SPEED = 10

var velocity = Vector2()

var dir = 1

func _physics_process(delta): #makes a block that moves horizontaly and changes direction when it hits a wall
	velocity.x = SPEED * dir
	velocity = move_and_slide(velocity)
	if is_on_wall():
		dir = dir * -1
