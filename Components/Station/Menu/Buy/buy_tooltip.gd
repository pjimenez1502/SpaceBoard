extends Control
class_name BuyTooltip

@onready var content: RichTextLabel = %Content
@onready var cost: Label = %Cost
@onready var attachment_name: Label = %Name
@onready var description: Label = %Description
var tween: Tween

func _ready() -> void:
	modulate.a = 0
	

func show_tooltip(value: bool) -> void:
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0 if value else 0.0, 0.1)

func populate(attachment_data: AttachmentData) -> void:
	content.text = ""
	content.text += populate_cost(attachment_data)
	content.text += "\n[b]%s[/b]" % attachment_data.name
	content.text += "\n\n%s" % attachment_data.description

func populate_cost(attachment_data: AttachmentData) -> String:
	var cost_text: String
	for resource: String in attachment_data.cost:
		match resource:
			"credits":
				cost_text += "[img]res://UI/Icon/Credits.png[/img] %s  " % Util.format_number(attachment_data.cost[resource])
			"iron":
				cost_text += "[img]res://UI/Icon/Iron.png[/img] %s  " % Util.format_number(attachment_data.cost[resource])
	
	if attachment_data.power_draw != 0:
		cost_text += "[img]res://UI/Icon/Power.png[/img] %d" % attachment_data.power_draw
	return cost_text
