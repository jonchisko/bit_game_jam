extends Node2D
class_name Heart


signal heart_beat


@export var start_period: float = 2.0
@export var min_period: float = 0.3


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: RandomStreamPlayer = $RandomStreamPlayer


func update_beat_speed(period_length: float) -> void:
	await self.heart_beat
	
	var actual_period = max(period_length, self.min_period)
	
	self.animation_player.get_animation("beat").length = actual_period
	
	# We have to adjust keys in animation from the rear otherwise we mess up they keys:
	# -> they get removed
	for indx in range(2, 0, -1):
		self.animation_player.get_animation("beat").track_set_key_time(0, indx, actual_period)
		actual_period /= 2.0
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.scale = Vector2.ZERO
	self.animation_player.play("in")
	await self.animation_player.animation_finished
	self.animation_player.play("beat")
	update_beat_speed(self.start_period)


func _do_heart_beat() -> void:
	self.heart_beat.emit()
	audio_stream_player.play_random()
