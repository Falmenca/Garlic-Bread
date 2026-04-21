extends CharacterBody2D

var health = 50
@export var speed = 100

var PosAttack : Vector2
var RandDistX = 0
var RandDistY = 0
var player 

func _ready():
	player = Global.player
	print(player)

func _physics_process(delta: float) -> void:
	
	if health < 1:
		_death()
	
	if position.distance_to(player.position)>200:
		PosAttack= Vector2(player.position.x + RandDistX, player.position.y + RandDistY)
	else:
		PosAttack = player.position
	
	var direction = (PosAttack - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func _death():
	pass
	#dies

func _on_pos_timer_timeout() -> void:
	RandDistX = randf_range(-200,200)
	RandDistY = randf_range(-200,200)

	print(RandDistY, RandDistX)
