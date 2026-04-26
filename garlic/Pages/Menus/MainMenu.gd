extends CanvasLayer

var currentSelection = 0

@onready var pressAnyButton = $Menus/PressAnyButton
@onready var mainOptions = [
	$Menus/MainMenuScreen/MenuOptions/Play,
	$Menus/MainMenuScreen/MenuOptions/Settings,
	$Menus/MainMenuScreen/MenuOptions/Credits,
	$Menus/MainMenuScreen/MenuOptions/Quit
]
var mainOptionsText = ["Play Game", "Settings", "Credits", "Quit"]
@onready var mainMenuScreen = $Menus/MainMenuScreen
@onready var mainArrow = $Menus/MainMenuScreen/MenuOptions/ArrowSelector
@onready var menuOptions = $Menus/MainMenuScreen/MenuOptions

func _ready() -> void:
	change_state(GameController.get_state())

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		return
	
	match GameController.state:
		GameController.GameState.INTRO:
			if event.is_pressed():
				change_state(GameController.GameState.MAIN)
				
		GameController.GameState.MAIN:
			_handle_menu_input(event, "main", mainOptions)

func _handle_menu_input(event: InputEvent, menu_type: String, options: Array = []) -> void:
	if event.is_action_pressed("ui_up"):
		currentSelection = posmod(currentSelection - 1, options.size())
		_update_selection(menu_type)
	elif event.is_action_pressed("ui_down"):
		currentSelection = posmod(currentSelection + 1, options.size())
		_update_selection(menu_type)
	elif event.is_action_pressed("ui_accept"):
		_execute_selection(menu_type)

func change_state(nextState: GameController.GameState) -> void:
	GameController.set_state(nextState)
	currentSelection = 0
	
	pressAnyButton.visible = false
	mainMenuScreen.visible = false
	
	match GameController.state:
		GameController.GameState.INTRO:
			pressAnyButton.visible = true
			
		GameController.GameState.MAIN:
			mainMenuScreen.visible = true
			_update_selection("main")
		
		GameController.GameState.CUTSCENE:
			get_tree().change_scene_to_file("res://Pages/Story/Intro_Cutscene.tscn")

func _update_selection(menuType: String) -> void:
	var options 
	var arrow
	var raw_text 
	
	match menuType:
		"main": 
			options = mainOptions
			raw_text = mainOptionsText
			arrow = mainArrow
	
	for i in range(options.size()):
		var label = options[i]
		
		if i == currentSelection:
			# Do Pulse effect for this selected text
			label.text = "[center][pulse freq=2.0 color=#ffffff66]%s[/pulse][/center]" % raw_text[i]
			# Move arrow to left side of selected option
			arrow.position.y = label.position.y + (label.size.y / 2) - 10
		else:
			label.text = "[center]%s[/center]" % raw_text[i]
	
func _execute_selection(menuType: String):
	if menuType == "main":
		match currentSelection:
			0: change_state(GameController.GameState.CUTSCENE)
			1: GameController.toggle_settings()
			2: get_tree().change_scene_to_file("res://Pages/Credits/Credits.tscn")
			3: get_tree().quit()
