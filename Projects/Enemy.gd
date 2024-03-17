extends CharacterBody2D

var speed = 100
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		velocity = (player.get_global_position() - position).normalized() * speed * delta
		move_and_collide(velocity)
		

func _on_detectionarea_body_entered(body):
	player = body
	player_chase = true


func _on_detectionarea_body_exited(body):
	player = null
	player_chase = false
