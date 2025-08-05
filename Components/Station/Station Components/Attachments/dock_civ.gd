extends Dock
class_name DockCivilian

func on_ship_dock(tier: int) -> void:
	super(tier)

func on_ship_release(tier: int) -> void:
	super(tier)
	pay_docking_fee()
	pay_fuel_fee()
	pay_repair_fee()



## INCOME
func pay_docking_fee() -> void:
	ResourceDirector.update_value("credits", 50)

func pay_fuel_fee() -> void:
	ResourceDirector.resource_sell("fuel", randi_range(0,2), 1.1)

func pay_repair_fee() -> void:
	ResourceDirector.resource_sell("alloy", randi_range(0,1), 1.1)
