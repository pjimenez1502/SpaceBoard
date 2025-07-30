extends Control

var attachment_dictionary: Dictionary = {
	"station_ring": preload("res://Data/Attachments/StationRing.tres"),
	"power_reactor": preload("res://Data/Attachments/Power_Reactor.tres"),
}



func buy_ring() -> void:
	var id: String = "station_ring"
	if !ResourceDirector.check_cost(attachment_dictionary[id].cost, StationDirector.st_rings.size()):
		return
	StationDirector.build_ring(attachment_dictionary[id].scene)

func buy_power_reactor() -> void:
	var id: String = "power_reactor"
	if !ResourceDirector.check_cost(attachment_dictionary[id].cost):
		return
	StationDirector.select_attachment(attachment_dictionary[id])
