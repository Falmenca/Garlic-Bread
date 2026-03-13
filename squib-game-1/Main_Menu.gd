extends Node

# Metadata in buttons determine index of level chosen. Starts at 0 for level 1.
var Levels: Array[String] = [
	"res://Levels/01/Level_1.tscn",
	"res://Levels/02/Level_2.tscn"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for lvl in $Background/Levels/LevelTree.get_children():
		var button = lvl.get_node("Button")
		button.pressed.connect(_on_game_pressed.bind(button))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_pressed(button):
	var index = button.get_meta("lvl_index")
	select_game(index)

func select_game(lvl_index: int):
	get_tree().change_scene_to_file(Levels[lvl_index])
