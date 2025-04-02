extends Node


func change_to_scene(scene: String) -> void:
	$AnimationPlayer.play("in")
	await $AnimationPlayer.animation_finished
	self.get_tree().change_scene_to_file(scene)
	$AnimationPlayer.play("out")
