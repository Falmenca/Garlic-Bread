extends Node

enum MenuState {
	# Main Menus
	INTRO,
	MAIN,
	
	# Main game
	GAMEPLAY,
	
	# Utility
	PAUSE,
	SETTINGS
}

var state: MenuState = MenuState.INTRO
var prevState: MenuState = MenuState.MAIN

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		return
		
	if event.is_action_pressed("Pause"):
		toggle_pause()
	
	if state == MenuState.PAUSE:
		Pause.handle_menu_input(event)
	
	if state == MenuState.SETTINGS:
		Settings.handle_menu_input(event)

func set_state(nextState: MenuState) -> void:
	state = nextState

func get_state() -> MenuState:
	return state

func toggle_pause():
	match state:
		MenuState.GAMEPLAY:
			set_state(MenuState.PAUSE)
			get_tree().paused = true
			Pause.pauseMenuScreen.visible = true
				
		MenuState.PAUSE:
			set_state(MenuState.GAMEPLAY)
			get_tree().paused = false
			Pause.pauseMenuScreen.visible = false

func toggle_settings():
	match state:
		MenuState.MAIN:
			prevState = MenuState.MAIN
			set_state(MenuState.SETTINGS)
			Settings.open_menu()

		MenuState.PAUSE:
			prevState = MenuState.PAUSE
			set_state(MenuState.SETTINGS)
			Settings.open_menu()

		MenuState.SETTINGS:
			set_state(prevState)
			Settings.close_menu()
