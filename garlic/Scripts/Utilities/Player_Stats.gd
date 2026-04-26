extends Node

#Default player stats
var pStats_default = {
	pname = "Goregirl",
	health = 100,
	max_health = 100,
	level = 1,
	strength = 10,
	defense = 5
}

#Player stats
var pStats = {}

func reset_pStats():
	pStats = pStats_default.duplicate(true)
