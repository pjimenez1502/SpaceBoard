extends Dock
class_name DockCargo

func on_ship_dock(tier: int) -> void:
	super(tier)
	ResourceDirector.fulfill_trade_in(tier)

func on_ship_release(tier: int) -> void:
	super(tier)
	ResourceDirector.fulfill_trade_out(tier)
