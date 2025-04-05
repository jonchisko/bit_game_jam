extends Node


signal to_main_menu
signal player_hit
signal player_won
signal player_death
signal player_pickup(item: Area2D)
signal heart_beat(nth_beat: int)
signal beats_per_second_update(bps: float)


func player_won_emit():
	print("Signal: Player won")
	self.player_won.emit()


func player_death_emit():
	print("Signal: Player death")
	self.player_death.emit()
	

func player_hit_emit():
	print("Signal: Player hit")
	self.player_hit.emit()
	

func player_pickup_emit(item: Area2D):
	print("Signal: Player pickup")
	self.player_pickup.emit(item)


func heart_beat_emit(nth_beat: int):
	print("Signal: Heart beat")
	self.heart_beat.emit(nth_beat)


func beats_per_second_update_emit(bps: float):
	print("Signal: Beats per second update")
	self.beats_per_second_update.emit(bps)
