extends KinematicBody2D

const GRAVITY = 100
const SPEED = 5
const FLOOR = Vector2(0,-1)

var velocity = Vector2()

var dir = 1

func _physics_process(delta):
	velocity.x = SPEED * dir
	$AnimationPlayer.play("Maggot Crawl")
	velocity.y = GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	if is_on_wall():
		dir = dir * -1
		$RayCast2D.position *= -1
	if $RayCast2D.is_colliding() == false:
		dir = dir * -1
		$RayCast2D.position *= -1


func _on_HitZone_body_entered(body):
	if body.is_in_group("Player"):
		print("hit player")
		if dir == -1:
			PlayerMovement.hit_player(10,-1)
		elif dir == 1:
			PlayerMovement.hit_player(10,1)
