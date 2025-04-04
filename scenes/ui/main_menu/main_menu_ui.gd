extends PanelContainer


@export var options_menu: OptionsMenu


var open_position: Vector2
var close_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.open_position = self.global_position
	self.close_position = self.open_position + Vector2(300, 0)
	
	if self.options_menu == null:
		printerr("OptionsMenu is missing in MainMenuUi")
		return
	self.options_menu.close.connect(self._enable_menu)


func _on_play_button_pressed() -> void:
	SceneTransition.change_to_scene("res://scenes/levels/main_level/game_level.tscn")


func _on_options_button_pressed() -> void:
	self.options_menu.open_menu()
	self._disable_menu()


func _on_quit_button_pressed() -> void:
	self.get_tree().quit()


func _disable_menu() -> void:
	self._tween_position(true)


func _enable_menu() -> void:
	self._tween_position(false)
	
	
func _tween_position(disable: bool) -> void:
	var tween = self.create_tween()
	var end_position = self.open_position
	if disable:
		end_position = self.close_position
	tween.tween_property(self, "global_position", end_position, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	await tween.finished
