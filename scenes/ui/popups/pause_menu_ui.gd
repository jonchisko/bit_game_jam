extends PanelContainer
class_name PauseMenuUi


signal unpause_clicked
signal main_menu_clicked


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func open_pause() -> void:
	self.animation_player.play("in")
	self.animation_player.animation_finished
	
	
func close_pause() -> void:
	self.animation_player.play("out")
	self.animation_player.animation_finished


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.scale = Vector2.ZERO


func _on_close_button_pressed() -> void:
	self.unpause_clicked.emit()


func _on_continue_button_pressed() -> void:
	self.unpause_clicked.emit()


func _on_main_menu_button_pressed() -> void:
	self.main_menu_clicked.emit()
