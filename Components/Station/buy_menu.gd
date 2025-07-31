extends Control

var attachment_dictionary: Dictionary = {
	"station_ring": preload("res://Data/Attachments/StationRing.tres"),
	"power_reactor": preload("res://Data/Attachments/Power_Reactor.tres"),
	"hangar_civilian": preload("res://Data/Attachments/Hangar_Civ.tres")
}



func buy_ring() -> void:
	buy_attachment("station_ring", StationDirector.st_rings.size())

func buy_power_reactor() -> void:
	buy_attachment("power_reactor")

func buy_hangar_civilian() -> void:
	buy_attachment("hangar_civilian")

func buy_attachment(id: String, cost_multiplier: int = 1) -> void:
	if !ResourceDirector.check_cost(attachment_dictionary[id].cost, cost_multiplier):
		return
	StationDirector.select_attachment(attachment_dictionary[id])
