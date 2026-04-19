extends CharacterBody2D

# Animation Player child node
@onready var player = $AnimatedSprite2D

# Properties
@export var speed = 250.0
var face_direction = "Front"
var animation_to_play = "Front_Idle"

# Start front idle animation on load
func _ready():
	player.stop()
	player.play("Front_Idle")

func _physics_process(_delta):
	# Reset velocity
	velocity = Vector2.ZERO
	
	# Add appropriate velocities depending on button press
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1.0 * speed
		# Only face left/right if not diagonal movement
		if velocity.y == 0.0:
			face_direction = "Left"
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1.0 * speed
		# Only face left/right if not diagonal movement
		if velocity.y == 0.0:
			face_direction = "Right"
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1.0 * speed
		face_direction = "Back"
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1.0 * speed
		face_direction = "Front"
		
	# All movement animations named appropriately, eg "Left_Idle" or "Back_Walk"
	animation_to_play = "run" if velocity.length() > 0.0 else "Idle"
	if animation_to_play == "Idle":
		player.stop()
	player.play(animation_to_play)
	
	# Move character, slide at collision
	move_and_slide()
