extends StationAttachment

@export var power_gen: int = 10

func on_build() -> void:
	powered = true
	generating_power(powered)
	super.on_build()

func generating_power(value: bool) -> void:
	powered = value
	var generated_power: int = power_gen if powered else 0
	ResourceDirector.update_power_gen(attachment_id, generated_power)
