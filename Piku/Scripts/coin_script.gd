extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("CharacterBody2D"):
		body.coin_amount += 1
		queue_free()
