extends Node2D


@export var paths: Array[Path2D] 

var _obstacle = preload("res://scenes/levels/prototype/obstacle_test.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	self._spawn()
	
	
func _spawn() -> void:
	var instantiated = self._obstacle.instantiate() as PathFollow2D
	var random_path = paths.pick_random() as Path2D
	random_path.add_child(instantiated)
