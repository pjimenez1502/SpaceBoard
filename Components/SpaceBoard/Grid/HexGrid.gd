@tool
extends Node3D
class_name HexGrid

const TILE_SIZE : float = 1.0
const HEX_TILE = preload("res://Components/SpaceBoard/Grid/hex_tile.tscn")

@onready var camera_3d: Camera3D = $"../Camera3D"

@export var board_size : Vector2 = Vector2(19,8)
@export_tool_button("Generate Grid")
var button_call: Callable = generate_grid

func _ready() -> void:
	generate_grid()

func generate_grid() -> void:
	clear_grid()
	for x in range(board_size.x):
		var tile_coordinates : Vector2 = Vector2.ZERO
		tile_coordinates.x = x * TILE_SIZE * cos(deg_to_rad(30))
		tile_coordinates.y = (0 if x % 2 == 0 else TILE_SIZE/2)
		for y in range(board_size.y):
			var tile : HexTile = HEX_TILE.instantiate()
			add_child(tile)
			tile.translate(Vector3(tile_coordinates.x, 0, tile_coordinates.y))
			tile_coordinates.y += TILE_SIZE
	
	place_camera()

func clear_grid() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()

func place_camera() -> void:
	camera_3d.position = Vector3(
		TILE_SIZE * cos(deg_to_rad(30)) * int(board_size.x/2),
		7,
		TILE_SIZE * int(board_size.y/2))
