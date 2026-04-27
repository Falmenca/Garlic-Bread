extends Node

func display_number(value: int, position: Vector2, is_critical: bool = false):
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 10
	number.label_settings = LabelSettings.new()

	var color = "#FFF"
	if is_critical:
		color = "#B22"
	if value == 0:
		color = "#FFF8"

	number.label_settings.font_color = color
	number.label_settings.font_size = 90 + ((value-30) * 0.10)
	number.label_settings.outline_color = "#000000"
	number.label_settings.outline_size = 40
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
# --- Fade + float tween ---
	var tween = create_tween()

	# float
	tween.tween_property(number, "position:y", number.position.y - 40, 0.15)\
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# Fade out
	tween.tween_property(number, "modulate:a", 0.0, 0.5)
	# Delete after animation
	tween.tween_callback(number.queue_free)
