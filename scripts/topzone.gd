extends Area2D

func _on_body_entered(body):
	if body.has_node("CollisionShape2D"):
		print("Enemy stomped!")

		# Bounce the player upward
		if body.has_method("set_velocity"):
			body.velocity.y = -200  # simple bounce
		elif "velocity" in body:
			body.velocity.y = -200

		# Remove this enemy (assumes TopZone is a child of enemy)
		get_parent().queue_free()
