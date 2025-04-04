extends Node


@export var beat_manager: BeatManager


var _pause_popup_ui: PackedScene = preload("res://scenes/ui/popups/pause_menu_ui.tscn")
var _end_popup_ui: PackedScene = preload("res://scenes/ui/popups/end_menu_ui.tscn")


var _instantaited_pause: PauseMenuUi = null
var _instantaited_end_menu: EndMenuUi = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self._instantaited_pause = self._pause_popup_ui.instantiate() as PauseMenuUi
	self.add_child(self._instantaited_pause)
	self._instantaited_pause.unpause_clicked.connect(self._on_pause_continue_clicked)
	self._instantaited_pause.main_menu_clicked.connect(self._on_pause_menu_clicked)
	
	self._instantaited_end_menu = self._end_popup_ui.instantiate() as EndMenuUi
	self.add_child(self._instantaited_end_menu)
	self._instantaited_end_menu.main_menu_clicked.connect(self._on_pause_menu_clicked)
	
	GameEvents.player_won.connect(self._open_end_menu.bind(true))
	GameEvents.player_death.connect(self._open_end_menu.bind(false))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not self.get_tree().paused and Input.is_action_just_pressed("pause"):
		self.get_tree().paused = true
		self._instantaited_pause.open_pause()
	elif self.get_tree().paused and Input.is_action_just_pressed("pause"):
		self.get_tree().paused = false
		self._instantaited_pause.close_pause()
	
	
func _open_end_menu(won: bool) -> void:
	self.get_tree().paused = true
	self._instantaited_end_menu.open_end_menu(won, self.beat_manager.current_beat)
	

func _on_pause_menu_clicked() -> void:
	self.get_tree().paused = false
	SceneTransition.change_to_scene("res://scenes/levels/main/main_menu.tscn")
	
	
func _on_pause_continue_clicked() -> void:
	self.get_tree().paused = false
	self._instantaited_pause.close_pause()
