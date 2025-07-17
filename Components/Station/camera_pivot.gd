extends Node3D
class_name CameraPivot

@export var rotate_speed: float = 1

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("rotate_right"):
		orbit_camera(1, delta)
	if Input.is_action_pressed("rotate_left"):
		orbit_camera(-1, delta)

func orbit_camera(direction: int, delta: float) -> void:
	rotate(Vector3.UP, direction * rotate_speed * delta / Engine.time_scale)
