extends Node

signal RESOURCES_UPDATE
signal POWER_UPDATE

var resources: Dictionary[String, int] = {
	"credits": 0,
	
	"iron": 0,
	"titanium": 0,
	"magnesium": 0,
	"uranium": 0,
	
	"alloy": 0, ## iron + titanium
	"munition": 0, ## iron + magnesium
	"reactor_fuel": 0, ## uranium
	
	#"crew": 0,
	#"civilian": 0,
	#"food": 0,
	#"water": 0,
}

var power_sources: Dictionary
var power_uses: Dictionary

func set_starting_resource_values() -> void:
	resources = {
		"credits": 100,
		"reactor_fuel": 0,
	}
	send_resource_update()

func check_value(resource: String, value: int) -> bool:
	if !resources.has(resource):
		printerr("Invalid Resource ID: ", resource)
		return false
	if resources[resource] + value < 0:
		printerr("Not enough of resource: %s." % resource)
		return false
	return true
	
func update_value(resource: String, value: int) -> void:
	resources[resource] += value
	send_resource_update()

func set_value(resource: String, value: int) -> void:
	resources[resource] = value
	send_resource_update()

func check_cost(cost: Dictionary, cost_multiplier: int = 1) -> bool:
	for resource: String in cost:
		if !check_value(resource, -cost[resource]*cost_multiplier):
			return false
	return true

func purchase_cost(cost: Dictionary, cost_multiplier: int = 1) -> void:
	last_purchase = cost
	for resource: String in cost:
		update_value(resource, -cost[resource]*cost_multiplier)
		print(-cost[resource]*cost_multiplier)
	

var last_purchase : Dictionary
func refund_last() -> void:
	for resource: String in last_purchase:
		update_value(resource, last_purchase[resource])


func update_power_gen(id: int, value: int) -> void:
	power_sources[id] = value
	send_power_update()
func update_power_use(id: int, value: int) -> void:
	power_uses[id] = value
	send_power_update()

func power_check() -> void:
	## Run through each power user and check if there is enough power remaining
	## Power as many as posible
	pass

func send_resource_update() -> void:
	RESOURCES_UPDATE.emit(resources)
func send_power_update() -> void:
	POWER_UPDATE.emit({"sources": power_sources, "uses": power_uses})
