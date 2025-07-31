extends Node3D

@export var rotation_speed : float = 0.2

func _physics_process(delta: float) -> void:
	rotate_object_local(Vector3.UP, rotation_speed * delta)
