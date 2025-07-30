extends Control

@onready var sim_speed: Label = $VBoxContainer/Speed

@onready var credits: Label = $VBoxContainer/Credits
@onready var scrap: Label = $VBoxContainer/Scrap
@onready var power: Label = $VBoxContainer/Power

func _ready() -> void:
	ResourceDirector.RESOURCES_UPDATE.connect(update_debug_resources)
	GameDirector.SIMSPEED_UPDATE.connect(update_simspeed)
	request_update()

func update_debug_resources(resources: Dictionary) -> void:
	if resources.has("credits"):
		credits.text = "Credits: %d" % resources["credits"]
	if resources.has("scrap"):
		scrap.text = "Scrap: %d" % resources["scrap"]
	if resources.has("power") or resources.has("used_power"):
		power.text = "Power: %d/%d" % [resources["used_power"], resources["power"]]
	print(resources)

func update_simspeed(simspeed: int) -> void:
	sim_speed.text = "Speed: %dX" % simspeed

func request_update() -> void:
	ResourceDirector.send_resource_update()
