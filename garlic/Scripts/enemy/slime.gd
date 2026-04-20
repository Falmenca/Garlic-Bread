extends CharacterBody2D

var health = 50
@export var speed = 100

var PosAttack : Vector2
var RandDist = 0
var player 

func _ready():
	player = Global.player
	print(player)

func _physics_process(delta: float) -> void:
	
	if health < 1:
		_death()
	
	if position.distance_to(player.position)>200:
		PosAttack= Vector2(player.position.x + RandDist, player.position.y + RandDist)
	else:
		PosAttack = player.position
	
	var direction = (PosAttack - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func _death():
	pass
	#dies

func _on_pos_timer_timeout() -> void:
	RandDist = randf_range(200,1000)
