extends CharacterBody2D

var speed = randi_range(15,150)
var health = randi_range(40,100)
var damage = randi_range(-10,-40)
@onready var player = get_parent().get_node("Player")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _physics_process(delta : float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x > 0
	
	if health <= 0:
		$AnimatedSprite2D.animation ="death"

func makepath() -> void:
	nav_agent.target_position = player.global_position
func _on_timer_timeout():
	makepath()


func _on_area_2d_body_entered(body):
	print("enemy hit")
	
#func delete():
	#queue_free()
