class_name Hurtbox
extends Area2D

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		if area != null and owner.has_method("take_damage"):
			owner.take_damage(area.damage)
			print(area.damage," damage taken")
 
