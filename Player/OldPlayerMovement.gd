extends KinematicBody2D

const GRAVITY = 10
const WATER_GRAV = 2
const WATER_JUMP_FORCE = -100
const JUMP_FORCE = -200

const MAX_FALL_SPEED = 1000
const MAX_SINK_SPEED = 100

const GROUND_SPEED = 100
const MAX_MOVE_SPEED = 1000
const MAX_WATER_MOVE_SPEED = 50

var knockback = 0
var is_knockback

var MOVE_SPEED = 0
onready var grav = GRAVITY
onready var jump = JUMP_FORCE
onready var max_fall = MAX_FALL_SPEED
onready var max_move_speed = MAX_MOVE_SPEED
var y_velo = 0
var move_dir = 0

var IN_WATER = false

func _physics_process(delta):
	move_dir = 0
	if is_knockback == true:
		#knockback_player()
		pass
	else:
		move_normal()

func move_normal():
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	if is_knockback:
		knockback_player()
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo),Vector2(0, -1))
	var grounded = is_on_floor()
	if grounded:
		MOVE_SPEED = GROUND_SPEED
	elif not grounded:
		MOVE_SPEED += 1
	y_velo += grav
	y_velo = clamp(y_velo,jump, max_fall)
	#if grounded and Input.is_action_pressed("jump"):
	if Input.is_action_just_pressed("jump"):
		y_velo += jump
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > max_fall:
		y_velo = max_fall
	if MOVE_SPEED > max_move_speed:
		MOVE_SPEED = max_move_speed
	
	print(is_on_floor())

func knockback_player():
#	print("knock back")
#	print(knockback)
#	print(is_knockback)
	y_velo += JUMP_FORCE
	#move_dir = knockback
	#move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo),Vector2(0, -1))
	#MOVE_SPEED = GROUND_SPEED
	#y_velo += jump
	#if MOVE_SPEED > max_move_speed:
		#MOVE_SPEED = max_move_speed
	

func hit_player(ammount,dir):
	PlayerStats.Health -= ammount
	knockback = dir
	is_knockback = true
#	print(PlayerStats.Health)
	

func _on_Area2D_area_entered(area):
	if area.is_in_group("Water"):
		print("water") # Replace with function body.
		grav = WATER_GRAV
		jump = WATER_JUMP_FORCE
		max_fall = MAX_SINK_SPEED
		max_move_speed = MAX_WATER_MOVE_SPEED

func _on_Area2D_area_exited(area):
	if area.is_in_group("Water"):
		print("exit water") # Replace with function body.
		y_velo += JUMP_FORCE
		grav = GRAVITY
		jump = JUMP_FORCE
		max_fall = MAX_FALL_SPEED
		max_move_speed = MAX_MOVE_SPEED
