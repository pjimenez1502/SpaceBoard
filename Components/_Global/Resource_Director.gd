extends Node

signal RESOURCES_UPDATE
signal POWER_UPDATE

enum MATERIAL {
	iron, titanium, magnesium, ice,
	alloy, munition, fuel, reactor_fuel
}

var resources: Dictionary[String, int] = {
	"credits": 0,
	
	"iron": 0,
	"titanium": 0,
	"magnesium": 0,
	"uranium": 0,
	"ice": 0,
	
	"alloy": 0, ## iron + titanium
	"munition": 0, ## iron + magnesium
	"fuel": 0, ## ice + uranium
	"reactor_fuel": 0, ## uranium
	
	#"crew": 0,
	#"civilian": 0,
	#"food": 0,
	#"water": 0,
}

func _ready() -> void:
	init_order_table()

func set_starting_resource_values() -> void:
	resources = {
		"credits": 8000,
		
		"iron": 0,
		"titanium": 0,
		"magnesium": 0,
		"uranium": 0,
		"ice": 0,
		
		"alloy": 0, ## iron + titanium
		"munition": 0, ## iron + magnesium
		"fuel": 0, ## ice + uranium
		"reactor_fuel": 0, ## uranium
	}
	send_resource_update()



## CREDITS =======================================================================================================================================
func check_cost(cost: Dictionary, cost_multiplier: int = 1) -> bool:
	for resource: String in cost:
		if !check_value(resource, -cost[resource]*cost_multiplier):
			return false
	return true
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

func purchase_cost(cost: Dictionary, cost_multiplier: int = 1) -> void:
	last_purchase = cost
	for resource: String in cost:
		update_value(resource, -cost[resource]*cost_multiplier)

var last_purchase : Dictionary
func refund_last() -> void:
	for resource: String in last_purchase:
		update_value(resource, last_purchase[resource])



## POWER =======================================================================================================================================
var power_sources: Dictionary
var power_uses: Dictionary

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



## TRADE =======================================================================================================================================
signal TRADE_UPDATE
var trade_price_table: Dictionary = {
	"iron": 10,
	"titanium": 30,
	"magnesium": 20,
	"uranium": 45,
	"ice": 2,
	
	"alloy": 40,
	"munition": 30,
	"fuel": 5,
	"reactor_fuel": 80,
}

var trade_orders: Dictionary[String, Dictionary]
func init_order_table() -> void:
	for resource: String in MATERIAL.keys():
		trade_orders[resource] = {"buy": 0, "sell": 0}

func add_buy_order(resource: String, value: int) -> void:
	var order_cost: int = value * trade_price_table[resource]
	if !check_value("credits", -order_cost):
		return
	update_value("credits", -order_cost)
	update_order(resource, value, "buy")

func add_sell_order(resource: String, value: int) -> void:
	update_order(resource, value, "sell")	

func update_order(resource: String, value: int, operation: String) -> void:
	trade_orders[resource][operation] += value
	TRADE_UPDATE.emit()

func get_current_order(resource: String) -> Array:
	return [trade_orders[resource]["buy"], trade_orders[resource]["sell"]]

func resource_sell(resource: String, quant: int, upcharge: int) -> void:
	var final_quant: int = quant
	if quant > resources[resource]:
		final_quant = resources[resource]
	update_value(resource, -final_quant)
	var sell_price: int = trade_price_table[resource] * upcharge
	update_value("credits", final_quant * sell_price)

func get_random_ordered_resource(operation: String) -> String:
	var loop_tries: int = 0
	while loop_tries < 6:
		var resource: String = trade_orders.keys().pick_random()
		if trade_orders[resource][operation] != 0:
			return resource
		loop_tries += 1
	#printerr("No order found")
	return ""

func fulfill_trade_in(tier: int) -> void:
	var cargo_cap: int = 6
	for i: int in range(tier):
		var res_found: String = get_random_ordered_resource("buy")
		if !res_found:
			continue
		var cargo_count: int = cargo_cap if trade_orders[res_found]["buy"] >= cargo_cap else trade_orders[res_found]["buy"]
		update_order(res_found, -cargo_count, "buy")
		update_value(res_found, cargo_count)

func fulfill_trade_out(tier: int) -> void:
	var cargo_cap: int = 6
	for i: int in range(tier):
		var res_found: String = get_random_ordered_resource("sell")
		if !res_found:
			continue
		var cargo_count: int = cargo_cap if trade_orders[res_found]["sell"] >= cargo_cap else trade_orders[res_found]["sell"]
		update_order(res_found, -cargo_count, "sell")
		resource_sell(res_found, cargo_count, 1)
