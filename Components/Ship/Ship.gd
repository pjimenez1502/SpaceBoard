extends Node3D
class_name Ship

signal SHIP_ARRIVED

func navigate(origin: Vector3, entry: Vector3, target:Vector3) -> void:
	global_position = origin
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", entry, 4).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "global_position", target, 1).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	SHIP_ARRIVED.emit()
	queue_free()
