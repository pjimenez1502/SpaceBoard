extends Control

@onready var sim_speed: RichTextLabel = $VBoxContainer/Speed

@onready var credits: RichTextLabel = $VBoxContainer/Credits
@onready var power: RichTextLabel = $VBoxContainer/Power

func _ready() -> void:
	ResourceDirector.RESOURCES_UPDATE.connect(update_debug_resources)
	ResourceDirector.POWER_UPDATE.connect(update_power)
	GameDirector.SIMSPEED_UPDATE.connect(update_simspeed)
	request_update()

func update_debug_resources(resources: Dictionary) -> void:
	if resources.has("credits"):
		credits.text = "[img]res://UI/Icon/Credits.png[/img] %s" % Util.format_number(resources["credits"])
	
	#print(resources)


func update_power(power_data: Dictionary) -> void:
	var power_generated: int = power_data["sources"].values().reduce(Util.sum, 0)
	var power_used: int = power_data["uses"].values().reduce(Util.sum, 0)
	
	power.text = "[img]res://UI/Icon/Power.png[/img] %d/%d" % [power_used, power_generated]

func update_simspeed(simspeed: int) -> void:
	if simspeed == 0:
		sim_speed.text = "Speed: Paused"
		return
	sim_speed.text = "Speed: %dX" % simspeed

func request_update() -> void:
	ResourceDirector.send_resource_update()
