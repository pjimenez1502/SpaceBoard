extends Node3D
class_name StationAttachment

@onready var level_meshes: Node3D = $Mesh/Levels
@onready var lvl_1: MeshInstance3D = $Mesh/Levels/lvl_1
@onready var lvl_2: MeshInstance3D = $Mesh/Levels/lvl_2
@onready var lvl_3: MeshInstance3D = $Mesh/Levels/lvl_3

var attachment_slot: int
var attatchment_level: int = 1

func set_level(level:int) -> void:
	attatchment_level = level
	for child in level_meshes:
		child.visible = false
	
	match attatchment_level:
		1:
			lvl_1.visible = true
		2:
			lvl_2.visible = true
		3:
			lvl_3.visible = true

func on_build() -> void:
	pass
func on_update() -> void:
	pass
func on_shutdown() -> void:
	pass
