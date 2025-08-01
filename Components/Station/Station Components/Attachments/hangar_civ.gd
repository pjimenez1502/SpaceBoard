extends StationAttachment

var ship_objects: Dictionary = {
	"s": preload("res://Components/Ship/Ship_Civ_S.tscn")
}

@onready var working_timer: Timer = %WorkingTimer
@onready var landing_target: Node3D = %LandingTarget
@onready var entry_target: Node3D = %EntryTarget
@onready var ship_space: Node = %ShipSpace

@export var ship_frequency : int

var ship_count: int = 0
var max_ship_count: int = 2

func on_build() -> void:
	super.on_build()
	start_work_timer()
	powered = true ##CHEATING POWER ON

func on_work() -> void:
	check_spawn_condition()

func check_spawn_condition() -> void:
	if !powered:
		return
	if ship_count >= max_ship_count:
		return
	spawn_incoming_ship()

func spawn_incoming_ship() -> void:
	spawn_ship(get_random_point(), landing_target.global_position).SHIP_ARRIVED.connect(start_ship_exit_timer)
	ship_count += 1

func spawn_outgoing_ship() -> void:
	spawn_ship(landing_target.global_position, get_random_point())
	ship_count -= 1
	ResourceDirector.update_value("credits", 10)

func spawn_ship(origin: Vector3, target: Vector3) -> Ship:
	var ship: Ship = select_ship_model()
	ship_space.add_child(ship)
	ship.navigate(origin, entry_target.global_position, target)
	return ship

func select_ship_model() -> Ship:
	return ship_objects.values().pick_random().instantiate()

func start_ship_exit_timer() -> void:
	get_tree().create_timer(30).timeout.connect(spawn_outgoing_ship)

func get_random_point() -> Vector3:
	var distance: int = 20
	var rand_angle: int = randi_range(0,6)
	var rand_point : Vector2 = distance * Vector2.from_angle(rand_angle)
	return Vector3(rand_point.x, randi_range(-10,10), rand_point.y)

func start_work_timer() -> void:
	working_timer.start(5)
	working_timer.timeout.connect(on_work)
