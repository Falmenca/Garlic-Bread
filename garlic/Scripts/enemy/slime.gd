extends CharacterBody2D

@onready var RotationOffset: Node2D = $RotationOffset
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var animShader: AnimationPlayer = $ShaderPlayer
@export var health = 50
@export var speed = 100

@export var MoveAttack : bool = true #toggle to enable movement on attacking

var Attacking : bool = false
var PosAttack : Vector2
var RandDistX = 0
var RandDistY = 0
var ChaseDist = 400
var AttackRange = 400
var player 

func _ready():
	player = Global.player
	print(player)

func _physics_process(delta: float) -> void:
	
	if health < 1:
		_death()
	
	if player:
		if (MoveAttack == false and not Attacking) or (MoveAttack == true):
			_chase()
		if (position.distance_to(player.position)<AttackRange) and (not Attacking):
			Attacking = true
			anim.play("attack")
	

	move_and_slide()

func _death():
	queue_free()
	#dies

func _chase(): # behavior to unstick enemies' balls from each other
	if position.distance_to(player.position)>ChaseDist:
		PosAttack= Vector2(player.position.x + RandDistX, player.position.y + RandDistY)
	else:
		PosAttack = player.position
	
	var direction = (PosAttack - global_position).normalized()
	velocity = direction * speed 
	RotationOffset.scale.x = sign(direction.x) #flips sprite/hitbox to direction

func _on_chase_timer_timeout() -> void:
	RandDistX = randf_range(-ChaseDist,ChaseDist)
	RandDistY = randf_range(-ChaseDist,ChaseDist)
	#print(RandDistY, RandDistX)
	
func take_damage(dmg): #works with hurtbox
	health = health - dmg
	animShader.play("hitflash")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		Attacking = false

func faggot_print():
	print("faggot")
