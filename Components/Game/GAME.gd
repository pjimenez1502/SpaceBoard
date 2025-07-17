extends Control

@onready var chromatic_aberration_filter: ColorRect = $"Chromatic Aberration Filter"

func _ready() -> void:
	SceneDirector.set_game_scene(self)
	SceneDirector.load_main_menu()
