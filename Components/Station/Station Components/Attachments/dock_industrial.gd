extends Dock
class_name DockIndustrial

@export var fuel_cost: int = 4

func _ready() -> void:
	ship_count = 2

func check_spawn_condition() -> void:
	if !powered:
		return
	print("Ship Count: %d" % ship_count)
	if ship_count <= 0:
		return
	if !ResourceDirector.check_value("fuel", -fuel_cost):
		return
	ResourceDirector.update_value("fuel", -4)
	print("out")
	spawn_outgoing_ship()

func on_ship_dock(tier:int) -> void:
	generate_mining_loot(tier)

func on_ship_release(tier: int) -> void:
	super.on_ship_release(tier)
	start_mining_sortie_timer(tier)


func start_mining_sortie_timer(tier: int) -> void:
	get_tree().create_timer(ship_stay_time).timeout.connect(spawn_incoming_ship)

func generate_mining_loot(tier: int) -> void:
	var ore_list : Array = ["iron", "titanium", "magnesium", "ice"]
	for i in range(tier):
		ResourceDirector.update_value(ore_list.pick_random(), randi_range(1,2))
