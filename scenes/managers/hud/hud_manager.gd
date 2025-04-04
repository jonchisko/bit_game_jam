extends Node

@export var beat_manager: BeatManager
@export var counter_bps: CounterUi
@export var counter_beats: CounterUi


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.beats_per_second_update.connect(self._on_beats_per_second_update)
	GameEvents.heart_beat.connect(self._on_heart_beat)
	
	self.counter_bps.set_counter_value(self.beat_manager.current_beats_per_second)

func _on_heart_beat(nth_beat: int) -> void:
	self.counter_beats.set_counter_value(nth_beat)
	

func _on_beats_per_second_update(bps: float) -> void:
	self.counter_bps.set_counter_value(bps)
