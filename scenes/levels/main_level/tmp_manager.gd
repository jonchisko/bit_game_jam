extends Node


@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(self._on_timeout)


func _on_timeout() -> void:
	GameEvents.heart_beat_emit()
