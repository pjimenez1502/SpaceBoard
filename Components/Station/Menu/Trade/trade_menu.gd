extends Control
class_name TradeMenu

@onready var content: Control = %Content
@onready var credit_count: Label = %CreditCount

func _ready() -> void:
	ResourceDirector.RESOURCES_UPDATE.connect(update_credits)
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

func update_credits(resources: Dictionary) -> void:
	if resources.has("credits"):
		credit_count.text = Util.format_number(resources["credits"])
