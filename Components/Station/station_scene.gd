extends Control
class_name StationScene

@onready var station_slot: Node3D = %Station

@export var rotation_speed : float = 0.2

func _physics_process(delta: float) -> void:
	station_slot.rotate_object_local(Vector3.UP, rotation_speed * delta)
