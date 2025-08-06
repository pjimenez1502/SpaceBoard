extends Control
class_name MiningMenu

func _ready() -> void:
	open_menu(false)

var open: bool
func toggle_open() -> void:
	open_menu(!open)

func open_menu(value: bool) -> void:
	visible = value
	open = value
