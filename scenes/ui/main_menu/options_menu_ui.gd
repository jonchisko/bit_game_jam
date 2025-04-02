extends PanelContainer
class_name OptionsMenu


signal close


@onready var master_slider: HSlider = %MasterSlider
@onready var sfx_slider: HSlider = %SfxSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var window_button: Button = %WindowButton


const WINDOW_ID: int = 0

var open_position: Vector2
var close_position: Vector2

func open_menu() -> void:
	self._update_display()
	
	var tween = self.create_tween()
	tween.tween_property(self, "global_position", self.open_position, 0.5)
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	await tween.finished


func _ready() -> void:
	self.open_position = self.global_position
	self.close_position = self.open_position - Vector2(300, 0)
	
	self.global_position = self.close_position
	self._update_display()
	
	
func _close_menu() -> void:
	self.close.emit()
	
	var tween = self.create_tween()
	tween.tween_property(self, "global_position", self.close_position, 0.5)
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	await tween.finished


func _update_display() -> void:
	self.master_slider.value = self._get_bus_volume_percent("Master")
	self.sfx_slider.value = self._get_bus_volume_percent("Music")
	self.music_slider.value = self._get_bus_volume_percent("SFX")
	
	var mode = DisplayServer.window_get_mode(self.WINDOW_ID)
	if mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		self.window_button.text = "WINDOWED"
	else:
		self.window_button.text = "FULLSCREEN"
	
	
func _on_master_slider_value_changed(value: float) -> void:
	self._set_bus_to_volume(value, "Master")


func _on_sfx_slider_value_changed(value: float) -> void:
	self._set_bus_to_volume(value, "SFX")


func _on_music_slider_value_changed(value: float) -> void:
	self._set_bus_to_volume(value, "Music")


func _set_bus_to_volume(value: float, bus_name: String) -> void:
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _get_bus_volume_percent(bus: String):
	var bus_index = AudioServer.get_bus_index(bus)
	return db_to_linear(AudioServer.get_bus_volume_db(bus_index))


func _on_window_button_pressed() -> void:
	var current_mode = DisplayServer.window_get_mode(self.WINDOW_ID)
	
	if current_mode == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN, self.WINDOW_ID)
		self.window_button.text = "WINDOWED"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED, self.WINDOW_ID)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false, self.WINDOW_ID)
		self.window_button.text = "FULLSCREEN"
	

func _on_close_button_pressed() -> void:
	self._close_menu()
