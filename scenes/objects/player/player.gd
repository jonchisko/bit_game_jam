extends PathFollow2D
class_name Player


@export var max_movement_speed: float = 3.0
@export var acceleration: float = 0.5

@onready var health_component: HealthComponent = $HealthComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _movement_speed: float = 0.0
var _explosion: PackedScene = preload("res://scenes/components/particle_effect/explosion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.health_component.health_null.connect(self._on_health_null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self._move(delta)


func _move(delta: float) -> void:
	var direction = 0.0
	if Input.is_action_pressed("move_left"):
		direction -= 1.0
	if Input.is_action_pressed("move_right"):
		direction += 1.0
		
	if direction == 0.0:
		if self._movement_speed > 0.0:
			self._movement_speed = max(self._movement_speed - self.acceleration * delta, 0.0)
		elif self._movement_speed < 0.0:
			self._movement_speed = min(self._movement_speed + self.acceleration * delta, 0.0)
	else:
		self._movement_speed += direction * self.acceleration * delta
	
	self.progress_ratio = clampf(self.progress_ratio + self._movement_speed, 0.0, 1.0)
	
	if self.progress_ratio == 0.0 or self.progress_ratio == 1.0:
		self._movement_speed = 0.0


func _explode() -> void:
	var instantiated = self._explosion.instantiate()
	self.get_tree().root.add_child(instantiated)
	instantiated.global_position = self.global_position
	

func _on_pick_up_area_area_entered(area: Area2D) -> void:
	GameEvents.player_pickup_emit(area)


func _on_trigger_area_area_entered(area: Area2D) -> void:
	GameEvents.player_hit_emit()
	self.health_component.hit(1)


func _on_health_null() -> void:
	self.animation_player.play("death")
	await self.animation_player.animation_finished
	
	GameEvents.player_death_emit()
	self.queue_free()
