extends CharacterBody2D

var speed = 200
var screen_size 
var is_attacking = false
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
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = "up"
		#$AnimatedSprite2D.flip_v = velocity.y > 0
	#elif velocity.x == 0 and velocity.y == 0:
		#$AnimatedSprite2D.animation = "idle
	elif Input.is_action_pressed("click_left"):
		$AnimatedSprite2D.animation = "slash"
	
	elif Input.is_action_pressed("click_right"):
		$AnimatedSprite2D.animation = "block"
	
	else:
		$AnimatedSprite2D.animation = "idle"
