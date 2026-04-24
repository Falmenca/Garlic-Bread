class_name Hurtbox
extends Area2D

func _ready() -> void:
	pass
	
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		if area != null and owner.has_method("take_damage"):
			owner.take_damage(area.damage)
			#print(owner,area.damage," Dmg")
		if area != null and owner.has_method("take_knockback"):
			var knockback_direction = (global_position - area.global_position).normalized()
			owner.take_knockback(knockback_direction, area.force, area.knockback_duration )
		else:
			print("faggothurtbox")
 
