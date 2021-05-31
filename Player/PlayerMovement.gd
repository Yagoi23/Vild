extends KinematicBody2D

export (int) var speed = 120
export (int) var jump_speed = -180
export (int) var gravity = 400

var velocity = Vector2.ZERO

export (float,0,1,0) var friction = 0.1
export (float,0,1,0) var acceleration = 0.25

enum state {RUNNING, JUMP, IDLE, SWIMMING, FALL}

var player_state = state.IDLE

func get_input():
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	if move_dir != 0:
		velocity.x = lerp(velocity.x, move_dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta):
	print(velocity)
	if velocity.x == 0:
		player_state = state.IDLE
	elif velocity.x != 0:
		player_state = state.IDLE
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_speed
			player_state = state.JUMP
	
	if velocity.y < 0:
		player_state = state.JUMP
	else:
		player_state = state.FALL
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
