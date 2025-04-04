extends PanelContainer
class_name CounterUi


@export var title: String = ""
@export var init_value: int = 0

@onready var label: Label = $MarginContainer/HBoxContainer/Label
@onready var label_2: Label = $MarginContainer/HBoxContainer/Label2


func set_counter_value(value: float) -> void:
	self.label_2.text = str(value)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.label.text = self.title
	self.label_2.text = str(self.init_value)
