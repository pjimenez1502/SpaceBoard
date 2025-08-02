extends Node3D
class_name Ship

@export var tier: int = 1
signal SHIP_ARRIVED
signal SHIP_LEFT

func navigate_in(origin: Vector3, entry: Vector3, target:Vector3) -> void:
	global_position = origin
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", entry, 4).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "global_position", target, 1).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	SHIP_ARRIVED.emit(tier)
	queue_free()

func navigate_out(origin: Vector3, entry: Vector3, target:Vector3) -> void:
	global_position = origin
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", entry, 2).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "global_position", target, 3).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	SHIP_LEFT.emit(tier)
	queue_free()
