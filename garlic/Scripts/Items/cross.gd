extends Node2D


@onready var anim : AnimationPlayer = $AnimationPlayer

func _on_hitbox_area_entered(area: Area2D) -> void:
	Global.player.take_damage(-20)
	queue_free()
