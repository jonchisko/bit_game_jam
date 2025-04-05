extends PanelContainer
class_name EndMenuUi


signal main_menu_clicked

@onready var title: Label = $MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Title
@onready var label: Label = $MarginContainer/VBoxContainer/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var _text: String = "Number of spawns"


func open_end_menu(won: bool, number_of_beats: int) -> void:
	if won:
		self.title.text = "Victory"
	else:
		self.title.text = "Defeat"
	
	self.label.text = "{text}: {number}".format({"text": self._text, "number": number_of_beats})
	self.animation_player.play("in")


func _ready() -> void:
	self.scale = Vector2.ZERO
	

func _on_main_menu_button_pressed() -> void:
	self.animation_player.play("out")
	main_menu_clicked.emit()
