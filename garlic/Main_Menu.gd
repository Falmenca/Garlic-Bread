extends Node

@onready var options = [
	$Background/MenuOptions/Play,
	$Background/MenuOptions/Settings,
	$Background/MenuOptions/Quit
]

@onready var arrow = $Background/MenuOptions/ArrowSelector
@onready var press_any_button = $Background/PressAnyButton
@onready var menu_options = $Background/MenuOptions

var firstTimeTriggered = false
var current_selection = 0

var Paths: Array[String] = [
	"res://Levels/01/Level_1.tscn",
	"res://Levels/02/Level_2.tscn"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Background/MenuOptions.visible = false
	press_any_button.visible = true
	update_selection()

func _input(event: InputEvent) -> void:
	# ignore mouse motion
	if event is InputEventMouseMotion:
		return
		
	if !firstTimeTriggered:
		if event.is_pressed():
			_start_menu()
			get_viewport().set_input_as_handled()
	else:
		if event.is_action_pressed("ui_up"):
			current_selection = posmod(current_selection - 1, options.size())
			update_selection()
		elif event.is_action_pressed("ui_down"):
			current_selection = posmod(current_selection + 1, options.size())
			update_selection()
		elif event.is_action_pressed("ui_accept"):
			execute_selection()

func _start_menu() -> void:
	firstTimeTriggered = true
	press_any_button.visible = false
	menu_options.visible = true

func update_selection():
	for i in range(options.size()):
		var label = options[i]
		var raw_text = label.name
		
		if i == current_selection:
			# Do Pulse effect for this selected text
			label.text = "[center][pulse freq=2.0 color=#ffffff66]%s[/pulse][/center]" % raw_text
			# Move arrow to left side of selected option
			arrow.global_position.y = label.global_position.y + (label.size.y / 2) - 10
		else:
			label.text = "[center]%s[/center]" % raw_text
	
func execute_selection():
	match current_selection:
		0: get_tree().change_scene_to_file("res://Story_Cutscene.tscn")
		1: print("Settings Pressed")
		2: get_tree().quit()
	
