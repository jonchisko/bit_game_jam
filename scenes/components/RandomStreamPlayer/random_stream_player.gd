extends AudioStreamPlayer
class_name RandomStreamPlayer

@export var random_audios: Array[AudioStream]


func play_random(from_position: float = 0.0, pitch_random_range: float = 0.0) -> void:
	self.stream = self.random_audios.pick_random()
	
	pitch_random_range = clampf(pitch_random_range, 0.0, 0.9)
	self.pitch_scale = randf_range(1.0 - pitch_random_range, 1.0 + pitch_random_range)
	
	self.play(from_position)
