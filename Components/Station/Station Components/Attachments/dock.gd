extends StationAttachment
class_name Dock

@export var ship_objects: Array[PackedScene]

@onready var working_timer: Timer = %WorkingTimer
@onready var landing_target: Node3D = %LandingTarget
@onready var entry_target: Node3D = %EntryTarget
@onready var ship_space: Node = %ShipSpace

@export var work_time : int = 5
@export var ship_stay_time: int = 30

var ship_count: int = 0
@export var max_ship_count: int = 2

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


func on_ship_dock(tier: int) -> void:
	start_ship_exit_timer()

func on_ship_release(tier: int) -> void:
	pass


func spawn_incoming_ship() -> void:
	ship_count += 1
	
	var ship: Ship = select_ship_model()
	ship_space.add_child(ship)
	ship.navigate_in(get_random_point(), entry_target.global_position, landing_target.global_position)
	ship.SHIP_ARRIVED.connect(on_ship_dock)

func spawn_outgoing_ship() -> void:
	ship_count -= 1
	
	var ship: Ship = select_ship_model()
	ship_space.add_child(ship)
	ship.navigate_out(landing_target.global_position, entry_target.global_position, get_random_point())
	ship.SHIP_LEFT.connect(on_ship_release)

func select_ship_model() -> Ship:
	return ship_objects.pick_random().instantiate()

func get_random_point() -> Vector3:
	var distance: int = 20
	var rand_angle: int = randi_range(0,6)
	var rand_point : Vector2 = distance * Vector2.from_angle(rand_angle)
	return Vector3(rand_point.x, randi_range(-10,10), rand_point.y)


func start_ship_exit_timer() -> void:
	get_tree().create_timer(ship_stay_time).timeout.connect(spawn_outgoing_ship)
func start_work_timer() -> void:
	working_timer.start(work_time)
	working_timer.timeout.connect(on_work)
