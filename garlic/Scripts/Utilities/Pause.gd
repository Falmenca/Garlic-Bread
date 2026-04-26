extends CanvasLayer

var currentSelection = 0

@onready var pauseOptions = [
	$Background/MenuOptions/Continue,
	$Background/MenuOptions/Settings,
	$Background/MenuOptions/Main_Menu,
	$Background/MenuOptions/Quit
]
var pauseOptionsText = ["Continue", "Settings", "Main Menu", "Quit Game"]

@onready var pauseMenuScreen = $Background
@onready var pauseArrow = $Background/MenuOptions/ArrowSelector

func _ready() -> void:
	pauseMenuScreen.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func handle_menu_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		currentSelection = posmod(currentSelection - 1, pauseOptions.size())
		_update_selection()
	elif event.is_action_pressed("ui_down"):
		currentSelection = posmod(currentSelection + 1, pauseOptions.size())
		_update_selection()
	elif event.is_action_pressed("ui_accept"):
		_execute_selection()

func _update_selection() -> void:
	var options = pauseOptions
	var raw_text = pauseOptionsText
	var arrow = pauseArrow

	for i in range(options.size()):
		var label = options[i]
		
		if i == currentSelection:
			# Do Pulse effect for this selected text
			label.text = "[center][pulse freq=2.0 color=#ffffff66]%s[/pulse][/center]" % raw_text[i]
			# Move arrow to left side of selected option
			arrow.position.y = label.position.y + (label.size.y / 2) - 10
		else:
			label.text = "[center]%s[/center]" % raw_text[i]
	
func _execute_selection():
	match currentSelection:
		0: GameController.toggle_pause()
		1: GameController.toggle_settings()
		2: 
			GameController.toggle_pause()
			GameController.set_state(GameController.GameState.MAIN)
			get_tree().change_scene_to_file("res://Pages/Menus/Main_Menu.tscn")
			
		3: get_tree().quit()

func open_menu():
	currentSelection = 0
	_update_selection()
	pauseMenuScreen.visible = true
	pauseArrow.visible = true
	
func close_menu():
	pauseMenuScreen.visible = false
