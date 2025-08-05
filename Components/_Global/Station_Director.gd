extends Node

const RING_HEIGHT : float = 0.5
var station: Node3D

var st_rings: Array[StationRing]
var st_attatchments: Array[StationAttachment]

func generate_new_station(station_slot: Node3D) -> void:
	station = station_slot
	build_ring(load("res://Components/Station/Station Components/station_ring.tscn"))

func build_ring(scene: PackedScene) -> void: ## TODO: SWITCH TO BUILD FROM RESOURCE DATA
	var ring_index: int = find_next_index()
	#print("NEXT_INDEX: ", ring_index)
	
	var new_ring: StationRing = scene.instantiate()
	station.add_child(new_ring)
	new_ring.position = Vector3.UP * ring_index * RING_HEIGHT
	st_rings.append(new_ring)

var selected_attachment_data : AttachmentData
func select_attachment(attachment_data: AttachmentData) -> void:
	selected_attachment_data = attachment_data
	show_slot_buttons(true)
func cancel_attachment_selection() -> void:
	selected_attachment_data = null
	show_slot_buttons(false)
func check_reselecting_attachment(attachment_id: String) -> bool:
	if !selected_attachment_data:
		return false
	if attachment_id == selected_attachment_data.id:
		return true
	return false

var last_attachment_id : int = 1
func build_attachment(ring: int, slot: int) -> void:
	var new_attachment : StationAttachment = selected_attachment_data.scene.instantiate()
	station.add_child(new_attachment)
	new_attachment.position = Vector3.UP * ring * RING_HEIGHT
	new_attachment.rotation = Vector3.UP * deg_to_rad(90 * slot)
	new_attachment.attachment_id = last_attachment_id
	new_attachment.power_draw = selected_attachment_data.power_draw
	
	st_attatchments.append(new_attachment)
	ResourceDirector.purchase_cost(selected_attachment_data.cost)
	
	new_attachment.on_build()
	show_slot_buttons(false)
	last_attachment_id += 1

func show_slot_buttons(value: bool) -> void:
	for ring: StationRing in st_rings:
		ring.show_slot_buttons(value)

func find_next_index() -> int:
	var ring_count : int = st_rings.size()
	if ring_count == 0:
		return 0
	if ring_count % 2 == 0:
		return -ring_count / 2
	return (ring_count / 2) + 1
