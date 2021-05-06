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
	
	var on_ground = is_on_floor()
	y_vel += gravity
	if on_ground and Input.action_press("jump"):
		y_vel -= jump_force
	if on_ground and y_vel >= 5:
		y_vel = 5
	if y_vel > max_fall_speed:
		y_vel = max_fall_speed 
