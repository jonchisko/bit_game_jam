extends Button

	
func _on_button_press() -> void:
	$AudioStreamPlayer.play()


func _on_tree_exited() -> void:
	self.pressed.disconnect(self._on_button_press)


func _on_tree_entered() -> void:
	self.pressed.connect(self._on_button_press)
