extends Control
class_name TradeMenu

@onready var content: Control = %Content

func _ready() -> void:
	open_menu(false)

var open: bool
func toggle_open() -> void:
	open_menu(!open)

func open_menu(value: bool) -> void:
	content.visible = value
	open = value
	update_rows()

func update_rows() -> void:
	ResourceDirector.TRADE_UPDATE.emit()
