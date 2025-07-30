extends Node

const STATION_SCENE = preload("res://Components/Station/station_scene.tscn")
const START_MENU = preload("res://Components/Game/Startmenu/StartMenu.tscn")

var GAME_SCENE : Node
var active_scene : Node

## SCENE LOADING
func load_main_menu() -> void:
	free_current_scene()
	var start_menu_scene : StartMenu = START_MENU.instantiate()
	set_new_scene(start_menu_scene)

func load_station_scene(load_from_save: bool, station_data: Dictionary = {}) -> StationScene:
	free_current_scene()
	var new_station_scene : StationScene = STATION_SCENE.instantiate()
	set_new_scene(new_station_scene)
	
	if load_from_save:
		printerr("Station Save Loading not implemented")
	
	return new_station_scene


## UTIL
func set_game_scene(scene : Node) -> void:
	GAME_SCENE = scene

func free_current_scene() -> void:
	if active_scene:
		GAME_SCENE.remove_child(active_scene)
		active_scene.queue_free()

func set_new_scene(scene: Node) -> void:
	GAME_SCENE.add_child(scene)
	active_scene = scene
