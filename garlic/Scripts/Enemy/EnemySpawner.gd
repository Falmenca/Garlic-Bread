## Spawns enemy around the player in a circle
# todo:
# timer and spawn rules
# read rest of data from json into enemy

extends Node

const SPAWN_RADIUS = 500

@onready var file = FileAccess.open("res://JSON/enemies.json", FileAccess.READ)
@onready var enemies = JSON.parse_string(file.get_as_text())
@onready var player = get_tree().get_first_node_in_group("player")
@onready var enemy_blueprint = preload("res://Scripts/Enemy/enemy.tscn")
@onready var enemy_instance

func spawn_enemy(type: String) -> void:
	## Spawns an enemy of set type around the player
	var spawn_angle = randf_range(0, TAU)
	var x_pos = player.position.x+cos(spawn_angle)*SPAWN_RADIUS
	var y_pos = player.position.y+sin(spawn_angle)*SPAWN_RADIUS
	var enemy_pos: Vector2 = Vector2(x_pos, y_pos)
	enemy_instance = enemy_blueprint.instantiate()
	var sprite = enemy_instance.get_node("Sprite2D")
	sprite.texture = load("res://" + enemies[type]["image"])
	for stat in enemies[type]:
		if(stat!="image"):
			enemy_instance.stats[stat]=enemies[type][stat]
	add_child(enemy_instance)
	enemy_instance.set_position(enemy_pos)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	spawn_enemy("example_enemy")
