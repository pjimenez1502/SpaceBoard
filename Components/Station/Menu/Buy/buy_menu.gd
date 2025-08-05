extends Control

@onready var buy_tooltip: BuyTooltip = %"Buy Tooltip"

var attachment_dictionary: Dictionary = {
	"station_ring": preload("res://Data/Attachments/StationRing.tres"),
	"power_reactor": preload("res://Data/Attachments/Power_Reactor.tres"),
	"power_solar": preload("res://Data/Attachments/Power_Solar.tres"),
	"dock_civilian": preload("res://Data/Attachments/Dock_Civ.tres"),
	"dock_cargo": preload("res://Data/Attachments/Dock_Cargo.tres"),
	"dock_industrial": preload("res://Data/Attachments/Dock_Industrial.tres"),
}


func buy_ring() -> void:
	if !ResourceDirector.check_cost(attachment_dictionary["station_ring"].cost, StationDirector.st_rings.size()):
		return
	ResourceDirector.purchase_cost(attachment_dictionary["station_ring"].cost, StationDirector.st_rings.size())
	StationDirector.build_ring(attachment_dictionary["station_ring"].scene)

func buy_power_reactor() -> void:
	select_attachment("power_reactor")
func buy_power_solar() -> void:
	select_attachment("power_solar")

func buy_dock_civilian() -> void:
	select_attachment("dock_civilian")
func buy_dock_cargo() -> void:
	select_attachment("dock_cargo")
func buy_dock_industrial() -> void:
	select_attachment("dock_industrial")


func select_attachment(id: String, cost_multiplier: int = 1) -> void:
	if StationDirector.check_reselecting_attachment(id):
		StationDirector.cancel_attachment_selection()
		return
	if !ResourceDirector.check_cost(attachment_dictionary[id].cost, cost_multiplier):
		return
	StationDirector.select_attachment(attachment_dictionary[id])

func show_tooltip(attachment: String) -> void:
	buy_tooltip.show_tooltip(true)
	buy_tooltip.populate(attachment_dictionary[attachment])

func hide_tooltip() -> void:
	buy_tooltip.show_tooltip(false)
