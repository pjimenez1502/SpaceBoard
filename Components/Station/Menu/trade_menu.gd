extends Control
class_name TradeMenu

@onready var content: Control = %Content

func toggle_open() -> void:
	content.visible = !content.visible
