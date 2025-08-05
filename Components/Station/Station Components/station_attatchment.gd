extends Node3D
class_name StationAttachment

@onready var power_on: MeshInstance3D = %Power_ON
@onready var power_off: MeshInstance3D = %Power_OFF

@onready var level_meshes: Node3D = $Mesh/Levels
@onready var lvl_1: Node3D = $Mesh/Levels/lvl_1
@onready var lvl_2: Node3D = $Mesh/Levels/lvl_2
@onready var lvl_3: Node3D = $Mesh/Levels/lvl_3

var attachment_id: int
var attachment_slot: int
var attatchment_level: int = 1

var power_draw: int
var powered: bool
var enabled: bool = true

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
	ResourceDirector.update_power_use(attachment_id, power_draw)

func on_work() -> void:
	pass
func on_update() -> void:
	pass
func on_shutdown() -> void:
	pass

func set_powered(value: bool) -> void:
	powered = value && enabled
	#print("%s: %s" % [self, powered])
	power_on.visible = powered
	power_off.visible = !powered
