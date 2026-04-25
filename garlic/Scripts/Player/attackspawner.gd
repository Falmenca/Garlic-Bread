extends Node

var attacks: Dictionary[String, PackedScene] = {
	"whipp": preload("res://Scripts/Attacks/whipp.tscn"),
	"poison": preload("res://Scripts/Attacks/poison.tscn"),
	"orbital": preload("res://Scripts/Attacks/orbital.tscn"),
	"grab": preload("res://Scripts/Attacks/grab.tscn")
}
var attack_levels: Dictionary[String, int] = {
	"whipp": 1,
	"poison": 1,
	"orbital": 1,
	"grab": 1
}
# every attack needs modifiable traits like:
#	>timer between attacks
#	>damage
#	>

func _physics_process(delta: float) -> void:
	#if(get_tree().get_nodes_in_group("enemies")):
	if is_instance_valid(Global.player):
		for attack_name in attacks:
			if not get_tree().get_first_node_in_group(attack_name) and attack_levels[attack_name]>0:
				var attack = spawn_attack(attacks[attack_name], attack_name)
				attack.level = attack_levels[attack_name]


func spawn_attack(attack_bp: Resource, attack_name: String) -> Node:
	## Turn Resource into child Node and add it to appropriate groups
	var attack_node: Node2D = attack_bp.instantiate()
	attack_node.position = Global.player.position
	add_child(attack_node)
	attack_node.add_to_group("attacks")
	attack_node.add_to_group(attack_name)
	return attack_node
