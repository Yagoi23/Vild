extends KinematicBody2D

const GRAVITY = 10
const JUMP_FORCE = -200
const MAX_FALL_SPEED = 1000

const GROUND_SPEED = 100
const MAX_MOVE_SPEED = 1000

var MOVE_SPEED = 0

var y_velo = 0

func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo),Vector2(0, -1))
	
	var grounded = is_on_floor()
	y_velo += GRAVITY
	#if grounded and Input.is_action_pressed("jump"):
	if Input.is_action_just_pressed("jump"):
		y_velo += JUMP_FORCE
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
	
	if grounded and MOVE_SPEED > GROUND_SPEED:
		MOVE_SPEED = GROUND_SPEED
	if not grounded:
		MOVE_SPEED += 1
	if MOVE_SPEED > MAX_MOVE_SPEED:
		MOVE_SPEED = MAX_MOVE_SPEED

