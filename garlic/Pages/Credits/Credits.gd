extends Node

@onready var main_text = $Background/Main
@onready var press_any_button = $Background/PressAnyButton

var reveal_main_text: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	main_text.visible_ratio = 0
	press_any_button.visible = false
	display_text()

func _input(event):
	if event.is_action_pressed("ui_accept") or event is InputEventMouseButton and event.is_pressed():
		if reveal_main_text and reveal_main_text.is_running():
			reveal_main_text.kill()
			main_text.visible_ratio = 1.0
	
	if event.is_action_pressed("ui_accept") and main_text.visible_ratio == 1.0 and press_any_button.visible == true:
		get_tree().change_scene_to_file("res://Pages/Menus/Main_Menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if main_text.visible_ratio == 1.0:
		press_any_button.visible = true

func display_text():
	
	# tween to animation visible ratio
	reveal_main_text = create_tween()
	reveal_main_text.tween_property(main_text, "visible_ratio", 1.0, 8.0)
