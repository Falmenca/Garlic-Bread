extends Node2D
var attacks: Dictionary[String, PackedScene] = {
	"whipp": preload("res://Scripts/Attacks/whipp.tscn"),
	"poison": preload("res://Scripts/Attacks/poison.tscn"),
	"orbital": preload("res://Scripts/Attacks/orbital.tscn"),
	"grab": preload("res://Scripts/Attacks/grab.tscn")
}

func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	#if(get_tree().get_nodes_in_group("enemies")):
		for attack in attacks:
			if not get_tree().get_first_node_in_group(attack): #replace with attack timer
				spawn_attack(attacks[attack], attack)


func spawn_attack(attack_bp: Resource, attack_name: String) -> Node:
	## Turn Resource into child Node and add it to appropriate groups
	var attack_node: Node2D = attack_bp.instantiate()
	add_child(attack_node)
	attack_node.add_to_group("attacks")
	attack_node.add_to_group(attack_name)
	return attack_node
