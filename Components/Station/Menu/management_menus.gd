extends Control

@onready var background: ColorRect = $Background
@onready var trade_menu: TradeMenu = %TradeMenu
@onready var mining_menu: MiningMenu = %MiningMenu

enum MENU {NONE, MINING, TRADE, }
var current_menu: MENU

func _ready() -> void:
	show_menu(MENU.NONE)

func show_menu(selected: MENU) -> void:
	match selected:
		MENU.NONE:
			close_all()
		MENU.MINING:
			open_mining_menu()
		MENU.TRADE:
			open_trade_menu()

func open_trade_menu() -> void:
	if current_menu == MENU.TRADE:
		close_all()
		return
	current_menu = MENU.TRADE
	background.visible = true
	trade_menu.open_menu(true)
	mining_menu.open_menu(false)

func open_mining_menu() -> void:
	if current_menu == MENU.MINING:
		close_all()
		return
	current_menu = MENU.MINING
	background.visible = true
	trade_menu.open_menu(false)
	mining_menu.open_menu(true)

func close_all() -> void:
	current_menu = MENU.NONE
	background.visible = false
	trade_menu.open_menu(false)
	mining_menu.open_menu(false)
