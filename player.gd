extends Area2D

@export var speed = 400 #how fast the player will move in pixels/second
var screen_size
var previous_velocity = Vector2.ZERO
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#hide()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	previous_velocity = velocity
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.y < 0:
		# and velocity.x == float(0)
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = false
	if velocity.y > 0:
		# and velocity.x == float(0)
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = true
	if velocity.x < 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = true
		#$AnimatedSprite2D.flip_v = velocity.y > 0 or previous_velocity.y > 0
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = false
		#$AnimatedSprite2D.flip_v = velocity.y > 0 or previous_velocity.y > 0
	
	#if velocity.x != 0:
		#$AnimatedSprite2D.animation = "walk"
		#$AnimatedSprite2D.flip_v = false
		## See the note below about boolean assignment.
		#$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = "up"
		#$AnimatedSprite2D.flip_v = velocity.y > 0
