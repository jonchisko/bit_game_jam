extends PathFollow2D


@export var speed: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = 0
	if Input.is_action_pressed("move_left"):
		dir -= 1
	elif Input.is_action_pressed("move_right"):
		dir += 1
		
	var dist = dir * speed * delta
	
	self.progress_ratio = clamp(self.progress_ratio + dist, 0, 1.0)
