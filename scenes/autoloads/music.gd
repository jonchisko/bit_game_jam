extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Music autoload")
	GameEvents.beats_per_second_update.connect(self._start_music)
	GameEvents.player_death.connect(self._stop_music)
	GameEvents.to_main_menu.connect(self._stop_music)
	

func _start_music(_bps: float) -> void:
	if not $AudioStreamPlayer.playing:
		print("Start music")
		$AudioStreamPlayer.play()
	

func _stop_music() -> void:
	if $AudioStreamPlayer.playing:
		print("Stop music")
		$AudioStreamPlayer.stop()
