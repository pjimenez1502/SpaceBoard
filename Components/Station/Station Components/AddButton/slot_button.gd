extends Node3D
class_name SlotButton

var level : int
@export var slot : int
var slot_in_use: bool

func buy_on_position() -> void:
	StationDirector.build_attachment(level, slot)
	set_slot_in_use(true)

func set_slot_in_use(value: bool) -> void:
	slot_in_use = value

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		buy_on_position()
