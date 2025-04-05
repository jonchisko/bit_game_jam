extends Node


@export var spawn_paths: Array[Path2D]

var _obstacle_scene: PackedScene = preload("res://scenes/objects/obstacle/obstacle.tscn")
var _is_linked = false

func _ready() -> void:
	pass


func _spawn_obstacle() -> void:
	var spawn_path = self.spawn_paths.pick_random()
	
	var instantiated = self._obstacle_scene.instantiate()
	spawn_path.add_child(instantiated)
	instantiated.set_scale(instantiated.original_scale)
	


func _on_timer_timeout() -> void:
	if not self._is_linked:
		GameEvents.beats_per_second_update.connect(self._update_spawn_time)
		self._is_linked = true
	
	self._spawn_obstacle()


func _update_spawn_time(_bps: float) -> void:
	await $Timer.timeout
	$Timer.wait_time *= 0.95
	print("New time for spawn: ", $Timer.wait_time)
