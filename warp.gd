extends Area2D

@export_file("*.tscn") var next_scene

func _on_body_entered(body):
	if body is Player:
		body.frozen = true
		
		$AnimationPlayer.stop()
		var a = create_tween()
		a.tween_property(
			$ColorRect,
			"scale",
			Vector2(0,0),
			1
		).set_trans(Tween.TRANS_EXPO)
		
		a = create_tween()
		
		a.tween_property(
			$ColorRect,
			"position",
			Vector2(40,40),
			1
		).set_trans(Tween.TRANS_EXPO)
		
		await a.finished
		
		get_tree().change_scene_to_file(next_scene)
