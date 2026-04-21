class_name Hurtbox
extends Area2D

func _on_hurtbox_area_entered(hitbox: Hitbox) -> void:
	if hitbox != null and owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		print(hitbox.damage," damage taken")
 
