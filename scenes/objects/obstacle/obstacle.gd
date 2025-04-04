extends PathFollow2D


@export var constant_speed: float = 0.1
@export var heart_beat_move: float = 0.1
@export var scale_increase: float = 0.4
@export var original_scale: Vector2 = Vector2(0.3, 0.3)

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _original_scale: Vector2
var _explosion_effect: PackedScene = preload("res://scenes/components/particle_effect/explosion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.heart_beat.connect(self._on_heart_beat_emit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.progress_ratio = clampf(self.progress_ratio + self.constant_speed * delta, 0.0, 1.0)

	self._increasse_size_with_progress()
	
	if self.progress_ratio == 1.0:
		queue_free()


func _increasse_size_with_progress() -> void:
	var amount = self.progress_ratio * self.scale_increase
	self.scale = self.original_scale + Vector2(amount, amount)


func _on_trigger_area_area_entered(area: Area2D) -> void:
	print("Hit player")
	
	self.animation_player.get_animation("hit").track_set_key_value(0, 0, self.scale)
	self.animation_player.get_animation("hit").track_set_key_value(0, 1, self.scale + Vector2.ONE * 0.3)
	self.animation_player.get_animation("hit").track_set_key_value(0, 0, self.scale)
	self.animation_player.play("hit")
	await self.animation_player.animation_finished
	
	var instantiate = self._explosion_effect.instantiate()
	self.get_tree().root.add_child(instantiate)
	instantiate.global_position = self.global_position
	

func _disable() -> void:
	$TriggerArea/CollisionShape2D.set_deferred("disabled", true)


func _on_heart_beat_emit() -> void:
	var tween = self.create_tween()
	tween.tween_method(self._tween_heart_beat_move.bind(self.progress_ratio + self.heart_beat_move), 0.0, 1.0, 0.2)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)


func _tween_heart_beat_move(percent: float, new_ratio: float) -> void:
	self.progress_ratio = min(lerpf(self.progress_ratio, new_ratio, percent), 1.0)
	
