extends StaticBody2D

var stats = {
	"health": 0,
	"speed": 0,
	"damage": 0
	}
@onready var player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	position = position.move_toward(player.position, stats["speed"] * 100 * delta)
