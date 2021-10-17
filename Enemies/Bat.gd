extends KinematicBody2D #extends a kinematic body 2d node
#this used to be a blank space
#const GRAVITY = 100 #old gravity variable
const SPEED = 25 # sets a movement speed so that it can easily be modified
const FLOOR = Vector2(0,-1) #sets the floor vector
#this used to be a blank space
var follow_player #variable that is used later to define wether or not the bat is following the player
#this used to be a blank space
onready var SPRITE = $Sprite # preloads the Sprite to reduce lag
onready var EnemySenseLight = $EnemySenseLight # preloads the light node to reduce lag
#var player = null #this is a now unused variable
#this used to be a blank space
var velocity = Vector2() #presets the velocity variable to the Vector2 format to avoid a variable type conflict
#this used to be a blank space
var health = 100 #sets the variable health to 100 it is set as a variabvle and refered to so that instances that would use said number can easily be modified by usin g this as a variable
#this used to be a blank space
var x_dir = 1 #presets the directiom to 1
var y_dir = 1 #presets the directiom to 1
#this used to be a blank space
var player_can_hit = false #wether or not the player can hit this enemy
#this used to be a blank space
enum state {NORMAL, KNOCKBACK} #this is the state machine that handles wether or not this enemy is being knockbacked
#this used to be a blank space
var enemy_state = state.NORMAL #presets the enemys state to normal
#this used to be a blank space
func _physics_process(delta): #
	if enemy_state == state.NORMAL: #checks if the  the enemy is in a normal state
		if follow_player == true:#if the variable follow player is true -> this is when the player has entered the bats detection range and it is set to move towards the player
			for node in get_tree().get_nodes_in_group("Player"):
				#dir = (node.global_position.x - global_position.x)#.normalized()
				var t = (node.global_position.x - global_position.x)#.normalized()
				if t < 0:
					x_dir = -1
					$Sprite.flip_h = true
				elif t > 0:
					x_dir = 1
					$Sprite.flip_h = false
				var k = (node.global_position.y - global_position.y)
				if k < 0:
					y_dir = -1
				elif k > 0:
					y_dir = 1
		velocity.x = SPEED * x_dir
		velocity.y = SPEED * y_dir
	#this used to be a blank space
		$AnimationPlayer.play("Bat Fly")
	if enemy_state == state.KNOCKBACK:
		velocity.x = SPEED * x_dir * 10
	if player_can_hit == true and PlayerStats.attacking == true:
		health -= PlayerStats.attack_power
		enemy_state = state.KNOCKBACK
		$KnockbackTimer.start()
		for node in get_tree().get_nodes_in_group("Player"):
				#dir = (node.global_position.x - global_position.x)#.normalized()
				var t = (node.global_position.x - global_position.x)#.normalized()
				if t < 0:
					x_dir = 1
					$Sprite.flip_h = true
				elif t > 0:
					x_dir = -1
					$Sprite.flip_h = false
#this used to be a blank space
#this used to be a blank space
	velocity = move_and_slide(velocity, FLOOR)
#this used to be a blank space
#this used to be a blank space
#this used to be a blank space
func _process(delta):
	if PlayerStats.Enemy_Sense == true:
		SPRITE.modulate = Color(255,0,0) # turn sprite red
		EnemySenseLight.enabled = true
	else:
		SPRITE.modulate = Color(255,255,255) # turn sprite white
		EnemySenseLight.enabled = false
	#this used to be a blank space
	#this used to be a blank space
	if health <= 0:
		PlayerStats.xp += 1
		queue_free()
#this used to be a blank space
func _on_DetectionZone_area_entered(area):
	if area.is_in_group("Player"):
		follow_player = true
#this used to be a blank space
#this used to be a blank space
func _on_DetectionZone_area_exited(area):
	if area.is_in_group("Player"):
		follow_player = false
#this used to be a blank space
func _on_HitZone_area_entered(area):
	if area.is_in_group("Player"):
		PlayerStats.hit_player(10)
	if area.is_in_group("Player_Attack"):
		player_can_hit = true
		#collider.hit_enemy()
		#print("Hit " + collider.name)
#this used to be a blank space
#this used to be a blank space
func _on_HitZone_area_exited(area):
	if area.is_in_group("Player_Attack"):
		player_can_hit = false
#this used to be a blank space
#this used to be a blank space
func _on_KnockbackTimer_timeout():
	enemy_state = state.NORMAL
#this used to be a blank space
