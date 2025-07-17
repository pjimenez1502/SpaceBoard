extends Control

@onready var sim_speed: Label = $VBoxContainer/Speed

@onready var credits: Label = $VBoxContainer/Credits
@onready var scrap: Label = $VBoxContainer/Scrap

func _ready() -> void:
	ResourceDirector.RESOURCES_UPDATE.connect(update_debug_resources)
	GameDirector.SIMSPEED_UPDATE.connect(update_simspeed)

func update_debug_resources(resources: Dictionary) -> void:
	if resources.has("credits"):
		credits.text = "Credits: %d" % resources["credits"]
	if resources.has("scrap"):
		scrap.text = "Scrap: %d" % resources["scrap"]

func update_simspeed(simspeed: int) -> void:
	sim_speed.text = "Speed: %dX" % simspeed
