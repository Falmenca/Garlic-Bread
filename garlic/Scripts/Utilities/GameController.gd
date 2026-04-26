extends Node

enum GameState {
	# Main Menus
	INTRO,
	MAIN,
	
	# Main game
	CUTSCENE,
	PLAY_ACTIVE,
	
	# Utility
	PAUSE,
	SETTINGS
}

var state: GameState = GameState.INTRO
var prevState: GameState = GameState.MAIN

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		return
		
	if event.is_action_pressed("Pause"):
		toggle_pause()
	
	if state == GameState.PAUSE:
		Pause.handle_menu_input(event)
	elif state == GameState.SETTINGS:
		Settings.handle_menu_input(event)

func set_state(nextState: GameState) -> void:
	state = nextState

func get_state() -> GameState:
	return state

func toggle_pause():
	get_viewport().set_input_as_handled()
	
	match state:
		GameState.PLAY_ACTIVE:
			set_state(GameState.PAUSE)
			get_tree().paused = true
			Pause.open_menu()
				
		GameState.PAUSE:
			set_state(GameState.PLAY_ACTIVE)
			get_tree().paused = false
			Pause.close_menu()

func toggle_settings():
	get_viewport().set_input_as_handled()
	
	match state:
		GameState.MAIN:
			prevState = GameState.MAIN
			set_state(GameState.SETTINGS)
			Settings.open_menu()

		GameState.PAUSE:
			prevState = GameState.PAUSE
			set_state(GameState.SETTINGS)
			Settings.open_menu()

		GameState.SETTINGS:
			set_state(prevState)
			Settings.close_menu()
