extends CharacterBody2D

signal hit
var speed = 200
var screen_size 
var is_attacking = false
var health = 100
var damage = -34
@onready var mob = get_parent().get_node("Enemy")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		
	if velocity.x != 0 and health > 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
	elif Input.is_action_pressed("click_left"):
		$AnimatedSprite2D.animation = "slash"
	
	elif health <= 0:
		$AnimatedSprite2D.animation = "death"
		hit.emit()
	else:
		$AnimatedSprite2D.animation = "idle"
	
	if health < 100 and health > 0:
		health += 0.05

func _on_area_2d_body_entered(body):
	health += mob.damage
	
