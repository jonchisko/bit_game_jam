extends PathFollow2D

@export var speed: float = 0.1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.progress_ratio += speed * delta
	if self.progress_ratio >= 1.0:
		call_deferred("queue_free")
