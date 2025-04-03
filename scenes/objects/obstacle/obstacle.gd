extends PathFollow2D


@export var constant_speed: float = 0.1
@export var heart_beat_move: float = 0.1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.heart_beat.connect(self._on_heart_beat_emit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.progress_ratio = clampf(self.progress_ratio + self.constant_speed * delta, 0.0, 1.0)


func _on_trigger_area_area_entered(area: Area2D) -> void:
	print("Hit player")


func _on_heart_beat_emit() -> void:
	var tween = self.create_tween()
	tween.tween_method(self.tween_heart_beat_move.bind(self.progress_ratio + self.heart_beat_move), 0.0, 1.0, 0.2)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)


func tween_heart_beat_move(percent: float, new_ratio: float) -> void:
	self.progress_ratio = min(lerpf(self.progress_ratio, new_ratio, percent), 1.0)
	
