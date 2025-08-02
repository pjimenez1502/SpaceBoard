extends Resource
class_name AttachmentData

@export var id: String
@export var name: String
@export var cost: Dictionary = {
	"credits": 0,
}
@export var power_draw: int
@export var scene: PackedScene
@export var description: String
