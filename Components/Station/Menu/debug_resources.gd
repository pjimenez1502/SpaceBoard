extends Control

@onready var sim_speed: Label = $VBoxContainer/Speed

@onready var credits: Label = $VBoxContainer/Credits
@onready var scrap: Label = $VBoxContainer/Scrap
@onready var power: Label = $VBoxContainer/Power

func _ready() -> void:
	ResourceDirector.RESOURCES_UPDATE.connect(update_debug_resources)
	ResourceDirector.POWER_UPDATE.connect(update_power)
	GameDirector.SIMSPEED_UPDATE.connect(update_simspeed)
	request_update()

func update_debug_resources(resources: Dictionary) -> void:
	if resources.has("credits"):
		credits.text = "Credits: %s" % Util.format_number(resources["credits"])
	if resources.has("scrap"):
		scrap.text = "Scrap: %d" % resources["scrap"]
	
	#print(resources)


func update_power(power_data: Dictionary) -> void:
	var power_generated: int = power_data["sources"].values().reduce(Util.sum, 0)
	var power_used: int = power_data["uses"].values().reduce(Util.sum, 0)
	
	power.text = "Power: %d/%d" % [power_used, power_generated]

func update_simspeed(simspeed: int) -> void:
	if simspeed == 0:
		sim_speed.text = "Speed: Paused"
		return
	sim_speed.text = "Speed: %dX" % simspeed

func request_update() -> void:
	ResourceDirector.send_resource_update()
