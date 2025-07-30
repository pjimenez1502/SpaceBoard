extends StationAttachment

@export var power: int = 40
@onready var refuel_check_timer: Timer = %RefuelCheckTimer
@onready var power_generation_timer: Timer = %PowerGenerationTimer

var working: bool = false

func on_build() -> void:
	check_refuel()

func on_shutdown() -> void:
	generating_power(false)

func check_refuel() -> void:
	generating_power(ResourceDirector.check_cost({"reactor_fuel": 1}))

func generating_power(value: bool) -> void:
	working = value
	var generated_power: int = power if working else 0
	ResourceDirector.update_power_gen(attachment_id, generated_power)
	print("REACTOR %d is generating %d power" % [attachment_id, generated_power])

func start_refuel_check() -> void:
	refuel_check_timer.start(5)
func start_power_gen() -> void:
	power_generation_timer.start(200)
