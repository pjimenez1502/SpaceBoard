extends Control
class_name StationScene

@onready var station: Station = $"SubViewportContainer/SubViewport/Station Scene/Station"

func get_station() -> Station:
	return station
