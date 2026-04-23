## Spawns enemy around the player in a circle
# todo:
# timer and spawn rules
# read rest of data from json into enemy

extends Node

const SPAWN_RADIUS = 1200

var file
var enemies
var player
@onready var enemy_blueprint = preload("res://Scripts/Enemy/slime.tscn")
@onready var enemy_instance

func _ready() -> void:
	file = FileAccess.open("res://Scripts/JSON/enemies.json", FileAccess.READ)
	enemies = JSON.parse_string(file.get_as_text())
	player = Global.player

func _physics_process(delta: float) -> void:
	#temp, spawn 20 enemies at most, put timer logic here later
	if get_tree().get_nodes_in_group("enemies").size() <= 1:
		spawn_enemy("slime", rand_around_x(player.position, SPAWN_RADIUS))
	else:
		pass


func rand_around_x(from_position: Vector2, distance: int):
	##Returns a position a distance away from a set position at a random angle
	var spawn_angle = randf_range(0, TAU)
	var x_pos = from_position.x+cos(spawn_angle)*distance
	var y_pos = from_position.y+sin(spawn_angle)*distance
	return Vector2(x_pos, y_pos)

func spawn_enemy(type: String, spawn_position: Vector2) -> void:
	## Spawns an enemy of set type at set location
	#Create a new enemy node
	enemy_instance = enemy_blueprint.instantiate()
	#Give the node an animation/sprite
	var sprite = enemy_instance.get_node("RotationOffset/AnimatedSprite2D")
	var frames = SpriteFrames.new()
	#Resize and give it stats
	enemy_instance.add_to_group("enemies")
	enemy_instance.set_position(spawn_position)
	#Spawn
	add_child(enemy_instance)
