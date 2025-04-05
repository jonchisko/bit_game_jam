extends Node
class_name BeatManager


@export var heart: Heart
@export var beat_per_second_increase: float = 0.1
@export var beat_increase_event_time: float = 1.0
@export var beat_win_condition: int = 10

var current_beat: int = 0
var current_beats_per_second: float = 0.1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.heart.heart_beat.connect(self._on_heart_beat)
	GameEvents.beats_per_second_update_emit(self.current_beats_per_second)
	self.heart.update_beat_speed(self._get_current_beat_period())
	
	$Timer.wait_time = self.beat_increase_event_time
	$Timer.start()


func _get_current_beat_period() -> float:
	return 1.0/self.current_beats_per_second


func _update_beats_per_second() -> void:
	self.current_beats_per_second += self.beat_per_second_increase
	self.heart.update_beat_speed(self._get_current_beat_period())


func _on_heart_beat() -> void:
	self.current_beat += 1
	GameEvents.heart_beat_emit(self.current_beat)
	if self.current_beat >= self.beat_win_condition:
		GameEvents.player_won_emit()


func _on_timer_timeout() -> void:
	self._update_beats_per_second()
	GameEvents.beats_per_second_update_emit(self.current_beats_per_second)
