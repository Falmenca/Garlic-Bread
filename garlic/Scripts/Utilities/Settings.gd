extends CanvasLayer

var currentSelection = 0
var active := false

@onready var settingsOptions = [
	$MenuOptions/FPS_Counter,
	$MenuOptions/Volume,
	$MenuOptions/Screen,
	$MenuOptions/Back
]
var settingsOptionsText = ["FPS Counter", "Volume", "Screen", "Back"]
@onready var settingsMenuScreen = $MenuOptions
@onready var settingsArrow = $MenuOptions/ArrowSelector

func _ready() -> void:
	settingsMenuScreen.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func handle_menu_input(event: InputEvent) -> void:
	if !active:
		return
		
	if event.is_action_pressed("ui_up"):
		currentSelection = posmod(currentSelection - 1, settingsOptions.size())
		_update_selection()
	elif event.is_action_pressed("ui_down"):
		currentSelection = posmod(currentSelection + 1, settingsOptions.size())
		_update_selection()
	elif event.is_action_pressed("ui_accept"):
		_execute_selection()

func _update_selection() -> void:
	var options = settingsOptions
	var raw_text = settingsOptionsText
	var arrow = settingsArrow

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
			0: FpsCounter.toggle_fps_display()
			1: print("Volume")
			2: print("Screen")
			3: MenuController.toggle_settings()

func open_menu():
	active = true
	currentSelection = 0
	_update_selection()
	settingsMenuScreen.visible = true
	settingsArrow.visible = true
	
func close_menu():
	active = false
	settingsMenuScreen.visible = false
