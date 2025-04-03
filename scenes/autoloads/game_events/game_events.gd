extends Node


signal player_hit
signal player_pickup(item: Area2D)
signal heart_beat


func player_hit_emit():
	print("Signal: Player hit")
	self.player_hit.emit()
	

func player_pickup_emit(item: Area2D):
	print("Signal: Player pickup")
	self.player_pickup.emit(item)


func heart_beat_emit():
	print("Signal: Heart beat")
	self.heart_beat.emit()
