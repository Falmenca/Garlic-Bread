extends CanvasLayer

@export var is_fps_toggled: bool = false 

func _process(_delta: float) -> void:
	$Label.text = "FPS: " + str(Engine.get_frames_per_second())
	
	if is_fps_toggled:
		$Label.visible = true
	else:
		$Label.visible = false

func toggle_fps_display():
	is_fps_toggled = !is_fps_toggled
