extends StationAttachment

@export var power: int = 40

func on_build() -> void:
	ResourceDirector.update_value("power", power)

func on_shutdown() -> void:
	ResourceDirector.update_value("power", -power)
