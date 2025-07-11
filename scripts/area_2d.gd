extends Area2D



func _on_body_entered(body):
	if body.is_in_group("Player"):
		var	current_scene = get_tree().current_scene.scene_file_path
		var current_lvl = current_scene.to_int() + 1
		print(current_lvl)
		
		var next_lvl_path = "res://levels/level_" + str(current_lvl) + ".tscn"
