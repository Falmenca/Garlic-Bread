extends Node

signal pStats_changed

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
	if pStats:
		pStats.clear()
	pStats = pStats_default.duplicate(true)

func set_pname(value: String):
	pStats.pname = value
	pStats.changed.emit()

func set_health(value: int):
	pStats.health = value
	pStats.changed.emit()

func set_max_health(value: int):
	pStats.max_health = value
	pStats.changed.emit()

func set_level(value: int):
	pStats.level = value
	pStats_changed.emit()

func set_strength(value: int):
	pStats.strength = value
	pStats_changed.emit()

func set_defense(value: int):
	pStats.defense = value
	pStats_changed.emit()
