extends Node2D

var level
var closest
var orb_distance=500
var orb_count=1
var orbs: Array[Node2D]
var current_angle = 0.0

func _ready() -> void:
	orbs.append($Orb)
	orbs.append($Orb.duplicate())
	add_child(orbs[1])
	orbs.append($Orb.duplicate())
	add_child(orbs[2])
	orbs.append($Orb.duplicate())
	add_child(orbs[3])


func _physics_process(delta: float) -> void:
	for i in range(orbs.size()):
		orbs[i].position = Global.player.position + pos_on_circle(orb_distance, (current_angle+i)*TAU/orbs.size())
	current_angle += delta
func pos_on_circle(distance: int, angle: float) -> Vector2:
	return Vector2(cos(angle), sin(angle))*distance
