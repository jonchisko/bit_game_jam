extends Node


@export var spawn_paths: Array[Path2D]

var _obstacle_scene: PackedScene = preload("res://scenes/objects/obstacle/obstacle.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _spawn_obstacle() -> void:
	var spawn_path = self.spawn_paths.pick_random()
	
	var instantiated = self._obstacle_scene.instantiate()
	spawn_path.add_child(instantiated)
	instantiated.set_scale(instantiated.original_scale)
	


func _on_timer_timeout() -> void:
	self._spawn_obstacle()
