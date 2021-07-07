extends KinematicBody2D

export (int) var speed = 120
export (int) var jump_speed = -180
export (int) var climb_speed = 0
export (int) var gravity = 400

var air_speed = 0

export (int) var water_gravity = 100
export (int) var water_jump_speed = -80
export (int) var water_speed = 60

var velocity = Vector2.ZERO

#export (float,0,1,0) var friction = 10
var friction = 10
export (float,0,1,0) var acceleration = 25

#export (float,0,1,0) var slide_friction = 0
#export (float,0,1,0) var slide_acceleration = 25

export (float,0,1,0) var water_acceleration = 5
export (float,0,1,0) var water_friction = 100

enum state {RUNNING, JUMP, IDLE, SWIMMING, FALL, KNOCKBACK, CLIMBING}

var player_state = state.IDLE

var move_dir

var in_water = false

var counter = 0

onready var Sprite = $Sprite

func get_input():
	move_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if player_state != state.KNOCKBACK and player_state != state.SWIMMING:
		if move_dir != 0:
			velocity.x = move_toward(velocity.x,move_dir*(speed+air_speed),acceleration)
		else:
			velocity.x = move_toward(velocity.x, 0, friction)
	elif player_state == state.SWIMMING:
		if move_dir != 0:
			velocity.x = move_toward(velocity.x,move_dir*water_speed,water_acceleration)
		else:
			velocity.x = move_toward(velocity.x, 0, water_friction)

func _physics_process(delta):
	if PlayerStats.Apply_Knockback == true:
		PlayerStats.Apply_Knockback = false
		player_state = state.KNOCKBACK
	#print(state.keys()[player_state])
	if player_state != state.KNOCKBACK:
		get_input()
#------------------------------------------------------------------------------
#SWIMMING
#------------------------------------------------------------------------------
		if player_state == state.SWIMMING:
			if Input.is_action_just_pressed("jump"):
					velocity.y = water_jump_speed
			velocity.y += water_gravity * delta
			velocity = move_and_slide(velocity, Vector2.UP)
#------------------------------------------------------------------------------
#NORMAL
#------------------------------------------------------------------------------
		elif player_state != state.SWIMMING:
			if velocity.x == 0:
				player_state = state.IDLE
			elif velocity.x != 0:
				player_state = state.RUNNING
			#if is_on_floor() and Input.is_action_just_pressed("jump"):
			if Input.is_action_just_pressed("jump"):
				velocity.y = jump_speed
				player_state = state.JUMP
			if not is_on_floor():
				if velocity.y <= 0:
					player_state = state.JUMP
				else:
					player_state = state.FALL
			if is_on_wall() and Input.is_action_just_pressed("jump"):
				velocity.y = jump_speed
				player_state = state.JUMP
			elif is_on_wall():
				player_state = state.CLIMBING
				velocity.y = climb_speed
		
			velocity.y += gravity * delta
			velocity = move_and_slide(velocity, Vector2.UP)
#------------------------------------------------------------------------------
#Knockback
#------------------------------------------------------------------------------
	elif player_state == state.KNOCKBACK:
		if counter == 0:
			velocity.y = -180 - rand_range(0,100)
		counter += 1
		if Sprite.visible == true:
			Sprite.visible = false
		else:
			Sprite.visible = true
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
		#print(counter)
		if counter == 60:
			player_state = state.JUMP
			counter = 0
			Sprite.visible = true
#------------------------------------------------------------------------------
#Air Speed
#------------------------------------------------------------------------------
	if is_on_floor() != true:
		air_speed +=1
	else:
		air_speed = 0

#func hit_player():
	#pass
	#PlayerStats.Health -= ammount
	#player_state = state.KNOCKBACK

func _on_Area2D_area_entered(area):
	
	if area.is_in_group("Water"):
		#if player_state != state.KNOCKBACK:
		print("water") # Replace with function body.
		velocity.y = 25
		player_state = state.SWIMMING

	if area.is_in_group("Slide"):
		#if player_state != state.KNOCKBACK:
		print("slide") # Replace with function body.
		friction = 0

	if area.is_in_group("Enemy"):
		counter = 0
		print("knockback")
		player_state = state.KNOCKBACK


func _on_Area2D_area_exited(area):
	if area.is_in_group("Water"):
		print("exit water") # Replace with function body.
		velocity.y = -200
		player_state = state.FALL

	if area.is_in_group("Slide"):
		#if player_state != state.KNOCKBACK:
		print("slide") # Replace with function body.
		friction = 10

