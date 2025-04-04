extends Node
class_name HealthComponent

signal health_null


@export var max_health: int = 3

var _health_points: int = 1


func _ready() -> void:
	self._health_points = self.max_health


func hit(by_amount: int) -> void:
	print("health is null")
	self._health_points = max(self._health_points - by_amount, 0)
	if self._health_points == 0:
		self.health_null.emit()
		
		
func heal(by_amount: int) -> void:
	self._health_points = min(self._health_points + by_amount, self.max_health)
