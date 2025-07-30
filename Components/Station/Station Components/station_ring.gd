extends Node3D
class_name StationRing

@onready var ring_meshes: Node3D = $Mesh/RingLevels
@onready var ring_lvl_1_: MeshInstance3D = $"Mesh/RingLevels/Ring(lvl1)"
@onready var ring_lvl_2_: MeshInstance3D = $"Mesh/RingLevels/Ring(lvl2)"
@onready var ring_lvl_3_: MeshInstance3D = $"Mesh/RingLevels/Ring(lvl3)"

var ring_slot: int = 0
var ring_level: int = 1

@export var slot_buttons : Array[SlotButton]
@export var support_per_level : int = 4
var used_slots: Array[int]

func _ready() -> void:
	show_slot_buttons(false)

func set_ring_level(level: int) -> void:
	ring_level = level
	for child in ring_meshes:
		child.visible = false
	
	match ring_level:
		1:
			ring_lvl_1_.visible = true
		2:
			ring_lvl_2_.visible = true
		3:
			ring_lvl_3_.visible = true

func show_slot_buttons(value: bool) -> void:
	for button: SlotButton in slot_buttons:
		if used_slots.has(button.slot):
			button.visible = false
		button.visible = value
