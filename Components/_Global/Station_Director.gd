extends Node

const asset_list: Dictionary = {
	"ring": preload("res://Components/Station/Station Components/station_ring.tscn"),
}

const RING_HEIGHT : float = 0.5
var station: Node3D

var st_rings: Array[StationRing]
var st_attatchments: Array[StationAttachment]

func generate_new_station(station_slot: Node3D) -> void:
	station = station_slot
	build_new_ring()

func build_new_ring() -> void:
	var ring_index: int = find_next_index()
	print("NEXT_INDEX: ", ring_index)
	var new_ring : StationRing = asset_list["ring"].instantiate()
	station.add_child(new_ring)
	new_ring.position = Vector3.UP * ring_index * RING_HEIGHT
	st_rings.append(new_ring)

func build_attachment(ring: int, slot: int, attatchment: StationAttachment) -> void:
	pass


func find_next_index() -> int:
	var ring_count : int = st_rings.size()
	if ring_count == 0:
		return 0
	if ring_count % 2 == 0:
		return -ring_count / 2
	return (ring_count / 2) + 1
