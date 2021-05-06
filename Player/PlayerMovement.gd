extends KinematicBody2D

const move_speed = 500
const jump_force = 500
const gravity = 50
const max_fall_speed = 500

var y_vel = 0

func _physics_process(delta):
	var move_dir = 0
	if Input.action_press("move_right"):
		move_dir += 1
	if Input.action_press("move_left"):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * move_speed, y_vel), Vector2(0,-1))
