extends KinematicBody2D

export (int) var speed = 120
export (int) var jump_speed = -180
export (int) var gravity = 400

export (int) var water_gravity = 10
export (int) var water_jump_speed = -80
export (int) var water_speed = 60

var velocity = Vector2.ZERO

export (float,0,1,0) var friction = 10
export (float,0,1,0) var acceleration = 25

export (float,0,1,0) var water_acceleration = 5
export (float,0,1,0) var water_friction = 100

enum state {RUNNING, JUMP, IDLE, SWIMMING, FALL, KNOCKBACK}

var player_state = state.IDLE

var move_dir

var in_water = false

func get_input():
	move_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if player_state != state.KNOCKBACK and player_state != state.SWIMMING:
		if move_dir != 0:
			velocity.x = move_toward(velocity.x,move_dir*speed,acceleration)
		else:
			velocity.x = move_toward(velocity.x, 0, friction)
	elif player_state == state.SWIMMING:
		if move_dir != 0:
			velocity.x = move_toward(velocity.x,move_dir*water_speed,water_acceleration)
		else:
			velocity.x = move_toward(velocity.x, 0, water_friction)

func _physics_process(delta):
	#print(velocity)
	#print(player_state)
	get_input()
	if player_state == state.KNOCKBACK:
		print("knockback 2")
		velocity.y = jump_speed
		velocity = move_and_slide(velocity, Vector2.UP)
		print(player_state)
		#player_state = state.JUMP
		print(player_state)
		#$Sprite.visible
	elif player_state == state.SWIMMING:
		if Input.is_action_just_pressed("jump"):
				velocity.y = water_jump_speed
		velocity.y += water_gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
	elif player_state != state.KNOCKBACK and player_state != state.SWIMMING:
		if velocity.x == 0:
			player_state = state.IDLE
		elif velocity.x != 0:
			player_state = state.RUNNING
		if is_on_floor():
			player_state = state.IDLE
			if Input.is_action_just_pressed("jump"):
				velocity.y = jump_speed
				player_state = state.JUMP
		#if is_on_wall():
		#	velocity.y = jump_speed
		#	player_state = state.JUMP
		
		if velocity.y < 0:
			player_state = state.JUMP
		else:
			player_state = state.FALL
		
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)

	

#func hit_player():
	#pass
	#PlayerStats.Health -= ammount
	#player_state = state.KNOCKBACK

func _on_Area2D_area_entered(area):
	if area.is_in_group("Water"):
		print("water") # Replace with function body.
		velocity.y = 25
		player_state = state.SWIMMING
	elif area.is_in_group("Enemy"):
		print("knockback")
		player_state = state.KNOCKBACK


func _on_Area2D_area_exited(area):
	if area.is_in_group("Water"):
		print("exit water") # Replace with function body.
		velocity.y = -200
		player_state = state.FALL
		
