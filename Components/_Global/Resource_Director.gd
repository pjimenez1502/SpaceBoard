extends Node

signal RESOURCES_UPDATE
signal POWER_UPDATE

var resources: Dictionary[String, int] = {
	"credits": 0,
	"reactor_fuel": 0,
	#"power": 0,
	#"used_power": 0,
	#"scrap": 0,
	#"alloy": 0,
	#"fuel": 0,
	#"jumpfuel": 0,
	#"crew": 0,
	#"pilot": 0,
	#"civilian": 0,
	#"food": 0,
	#"water": 0,
}

var power_sources: Dictionary
var power_uses: Dictionary

func set_starting_resource_values() -> void:
	resources = {
		"credits": 100,
		"reactor_fuel": 5,
		#"power": 0,
		#"used_power": 0,
		#"scrap": 100,
		#"alloy": 10,
		#"fuel": 100,
		#"jumpfuel": 10,
		#"crew": 40,
		#"pilot": 20,
		#"civilian": 60,
		#"food": 100,
		#"water": 100,
	}
	send_resource_update()

func update_value(resource: String, value: int) -> bool:
	if !resources.has(resource):
		printerr("Invalid Resource ID: ", resource)
		return false
	if resources[resource] + value < 0:
		printerr("Tried to update resource below 0.")
		return false
	
	resources[resource] += value
	#print(resources)
	send_resource_update()
	return true

func set_value(resource: String, value: int) -> void:
	resources[resource] = value
	send_resource_update()

func check_cost(cost: Dictionary, cost_multiplier: int = 1) -> bool:
	for resource: String in cost:
		if !update_value(resource, -cost[resource]):
			return false
	last_bought = cost
	return true

var last_bought : Dictionary
func refund_last() -> void:
	for resource: String in last_bought:
		update_value(resource, last_bought[resource])


func update_power_gen(id: int, value: int) -> void:
	power_sources[id] = value
	send_power_update()
func update_power_use(id: int, value: int) -> void:
	power_uses[id] = value
	send_power_update()

func send_resource_update() -> void:
	RESOURCES_UPDATE.emit(resources)
func send_power_update() -> void:
	POWER_UPDATE.emit({"sources": power_sources, "uses": power_uses})
