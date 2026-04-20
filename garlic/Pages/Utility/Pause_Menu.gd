extends Node

@onready var options = [
	$Background/MenuOptions/Continue,
	$Background/MenuOptions/Settings,
	$Background/MenuOptions/Main_Menu,
	$Background/MenuOptions/Quit
]
var option_texts = ["Continue", "Settings", "Main Menu", "Quit"]

@onready var pause_screen = $Background
@onready var arrow = $Background/MenuOptions/ArrowSelector

var current_selection = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_screen.visible = get_tree().paused
	update_selection()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		toggle_pause_menu()
		return
	
	if not get_tree().paused:
		return
	
	if event.is_action_pressed("ui_up"):
		current_selection = posmod(current_selection - 1, options.size())
		update_selection()
	elif event.is_action_pressed("ui_down"):
		current_selection = posmod(current_selection + 1, options.size())
		update_selection()
	elif event.is_action_pressed("ui_accept"):
		execute_selection()

func update_selection():
	for i in range(options.size()):
		var label = options[i]
		var raw_text = option_texts[i]
		
		if i == current_selection:
			# Do Pulse effect for this selected text
			label.text = "[center][pulse freq=2.0 color=#ffffff66]%s[/pulse][/center]" % raw_text
			# Move arrow to left side of selected option
			arrow.global_position.y = label.global_position.y + (label.size.y / 2) - 10
		else:
			label.text = "[center]%s[/center]" % raw_text
	
func execute_selection():
	match current_selection:
		0: toggle_pause_menu()
		1: 
			# go to settings here
			print("Settings Pressed")
		2: 	
			toggle_pause_menu()
			get_tree().change_scene_to_file("res://Pages/Main_Menu.tscn")
		3: get_tree().quit()

func toggle_pause_menu():
	current_selection = 0 # reset to first option on menu
	update_selection()
	
	get_tree().paused = !get_tree().paused
	pause_screen.visible = get_tree().paused
