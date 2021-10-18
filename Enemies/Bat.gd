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
var player_can_hit = false #weather or not the player can hit this enemy
#this used to be a blank space
enum state {NORMAL, KNOCKBACK} #this is the state machine that handles wether or not this enemy is being knockbacked
#this used to be a blank space
var enemy_state = state.NORMAL #presets the enemys state to normal
#this used to be a blank space
func _physics_process(delta): #
	if enemy_state == state.NORMAL: #checks if the  the enemy is in a normal state
		if follow_player == true:#if the variable follow player is true -> this is when the player has entered the bats detection range and it is set to move towards the player
			for node in get_tree().get_nodes_in_group("Player"): #finds the nodes in the tree in the group player
				#dir = (node.global_position.x - global_position.x)#.normalized() # old code
				var t = (node.global_position.x - global_position.x)#.normalized() #sets the variable t to the x cordinate of the player - this nodes current x position
				if t < 0: #if t is less the 0 -> if the player is in the negative direction in proportion to this node
					x_dir = -1 #makes the x dir negative 1 which makes the enemy move in the negative direction
					$Sprite.flip_h = true #flips the sprite so it points in the negative direction
				elif t > 0: #if t is greater then 0 -> if the player is in the positive direction in proportion to this node
					x_dir = 1 #makes the x dir 1 which makes the enemy move in the positive direction
					$Sprite.flip_h = false #makes the sprite not flipped
				var k = (node.global_position.y - global_position.y)#finds the players y position in relation to this nodes
				if k < 0: #if k is less then 0 -> if the player is in the negative y direction in proportion to this node
					y_dir = -1 #makes the y dir negative 1 which makes the enemy move in the negative y direction
				elif k > 0: #if k is greater then 0 -> if the player is in the positive y direction in proportion to this node
					y_dir = 1 #makes the y dir positive 1 which makes the enemy move in the positive y direction
		velocity.x = SPEED * x_dir #sets this nodes x velocity to SPEED multiplied by the x direction making the enemy move towards the player on the x axis
		velocity.y = SPEED * y_dir #sets this nodes y velocity to SPEED multiplied by the y direction making the enemy move towards the player on the y axis
	#this used to be a blank space
		$AnimationPlayer.play("Bat Fly") #plays the flying animation
	if enemy_state == state.KNOCKBACK: #if this node is in the knockback state
		velocity.x = SPEED * x_dir * 10 #moves the enemy when it is being knockbacked
	if player_can_hit == true and PlayerStats.attacking == true: #if the variable player can hit is true and the player is attacking
		health -= PlayerStats.attack_power #decreases this nodes health variable by the players attack power
		enemy_state = state.KNOCKBACK #sets the enemy state to the knockback state
		$KnockbackTimer.start() #starts atimer that controls how long the enemy is in the knockback state
		for node in get_tree().get_nodes_in_group("Player"): #finds the player node in the tree
				#dir = (node.global_position.x - global_position.x)#.normalized() # old code
				var t = (node.global_position.x - global_position.x)#.normalized() #sets the variable t to the x cordinate of the player - this nodes current x position
				if t < 0: #if t is less then 0
					x_dir = 1 #sets this nodes x direction to the opposite direction of the player in this case the positive direction
					$Sprite.flip_h = true #sets the sprite flip to true
				elif t > 0: #if t is greater then 0
					x_dir = -1 #sets this nodes x direction to the opposite direction of the player in this case the negative direction
					$Sprite.flip_h = false #sets the sprite flip to false
#this used to be a blank space
#this used to be a blank space
	velocity = move_and_slide(velocity, FLOOR) #sets this nodes velocity and makes it move and slide in proportion to the floor vector
#this used to be a blank space
#this used to be a blank space
#this used to be a blank space
func _process(delta): #func process
	#if PlayerStats.Enemy_Sense == true: #old code
	#	SPRITE.modulate = Color(255,0,0) # turn sprite red #old code
	#	EnemySenseLight.enabled = true #old code
	#else: #old code
	#	SPRITE.modulate = Color(255,255,255) # turn sprite white #old code
	#	EnemySenseLight.enabled = false #old code
	#this used to be a blank space #old code
	#this used to be a blank space #old code
	if health <= 0: #if this nodes health was less then or equal to 0
		PlayerStats.xp += 1 #increases the players xp
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
