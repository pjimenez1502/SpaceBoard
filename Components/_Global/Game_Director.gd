extends Node

signal SIMSPEED_UPDATE

func start_new_game() -> void:
	ResourceDirector.set_starting_resource_values()
	var station_scene: StationScene = SceneDirector.load_station_scene(false)
	StationDirector.generate_new_station(station_scene.station_slot)

var sim_speeds : Array[int] = [1,2,4,8]
var selected_simspeed_index : int = 1

#func loop_sim_speed() -> void:
	#selected_simspeed_index = (selected_simspeed_index + 1) % sim_speeds.size()
	#set_sim_speed(sim_speeds[selected_simspeed_index-1])

func set_sim_speed(value: int) -> void:
	Engine.time_scale = value
	SIMSPEED_UPDATE.emit(Engine.time_scale)

var paused: bool
func pause_game(value: bool) -> void:
	paused = value
	set_pause_subtree(StationDirector.station, value)
	if !value:
		set_sim_speed(1)
	if value:
		SIMSPEED_UPDATE.emit(0)

func set_pause_subtree(root: Node, pause: bool) -> void:
	var process_setters: Array[String] = ["set_process",
	"set_physics_process",
	"set_process_input",
	"set_process_unhandled_input",
	"set_process_unhandled_key_input",
	"set_process_shortcut_input",]
	
	for setter: String in process_setters:
		root.propagate_call(setter, [!pause])

func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("SimSpeedToggle"):
		#loop_sim_speed()
	
	if event.is_action_pressed("Speed 1"):
		pause_game(false)
		set_sim_speed(sim_speeds[0])
	if event.is_action_pressed("Speed 2"):
		pause_game(false)
		set_sim_speed(sim_speeds[1])
	if event.is_action_pressed("Speed 3"):
		pause_game(false)
		set_sim_speed(sim_speeds[2])
	if event.is_action_pressed("Speed 4"):
		pause_game(false)
		set_sim_speed(sim_speeds[3])
	
	if event.is_action_pressed("Pause"):
		pause_game(!paused)
