extends StationAttachment

@onready var refuel_check_timer: Timer = %RefuelCheckTimer
@onready var power_generation_timer: Timer = %PowerGenerationTimer
@export var power_gen: int = 40


func on_build() -> void:
	check_refuel()
	super.on_build()

func on_shutdown() -> void:
	generating_power(false)

func check_refuel() -> void:
	generating_power(ResourceDirector.check_cost({"reactor_fuel": 1}))

func generating_power(value: bool) -> void:
	powered = value
	var generated_power: int = power_gen if powered else 0
	ResourceDirector.update_power_gen(attachment_id, generated_power)
	print("REACTOR %d is generating %d power" % [attachment_id, generated_power])

func start_refuel_check() -> void:
	refuel_check_timer.start(5)
func start_power_gen() -> void:
	power_generation_timer.start(200)
