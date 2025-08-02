extends HBoxContainer
class_name TradeRow

@onready var title: Label = %Title
@onready var price: Label = %Price
@onready var stored: Label = %Stored
@onready var buy_input: SpinBox = %"Buy Input"
@onready var sell_input: SpinBox = %"Sell Input"
@onready var current_order: Label = %"Current Order"

@export var resource: ResourceDirector.MATERIAL
var resource_id: String

func _ready() -> void:
	resource_id = ResourceDirector.MATERIAL.keys()[resource]
	title.text = resource_id.capitalize()
	price.text = "%dC" % ResourceDirector.trade_price_table[resource_id]
	ResourceDirector.TRADE_UPDATE.connect(update)

func update() -> void:
	stored.text = "%d" % ResourceDirector.resources[resource_id]
	current_order.text = "%d/%d" % ResourceDirector.get_current_order(resource_id)

func order_buy() -> void:
	ResourceDirector.add_buy_order(resource_id, buy_input.value)

func order_sell() -> void:
	ResourceDirector.add_sell_order(resource_id, sell_input.value)
