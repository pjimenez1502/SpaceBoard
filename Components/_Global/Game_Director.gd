extends Node

var station : Station

signal SIMSPEED_UPDATE

func start_new_game() -> void:
	station = SceneDirector.load_station_scene(false)
	ResourceDirector.set_starting_resource_values()

var sim_speeds : Array[int] = [1,2,4,8]
var selected_simspeed_index : int = 1
func loop_sim_speed() -> void:
	selected_simspeed_index = (selected_simspeed_index + 1) % sim_speeds.size()
	print(selected_simspeed_index-1)
	set_sim_speed(sim_speeds[selected_simspeed_index-1])

func set_sim_speed(value: int) -> void:
	Engine.time_scale = value
	SIMSPEED_UPDATE.emit(Engine.time_scale)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("SimSpeedToggle"):
		loop_sim_speed()
