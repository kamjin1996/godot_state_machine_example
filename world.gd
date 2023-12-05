extends Node2D


@onready var camera_2d_2: Camera2D = $Player/Camera2D2
@onready var tile_map: TileMap = $TileMap


#限制相机下，左，右的边界
func _ready() -> void:
	var used := tile_map.get_used_rect().grow(-1)
	var tile_size = tile_map.tile_set.tile_size

	#camera_2d_2.limit_top = used.position.y * tile_size.y
	camera_2d_2.limit_right = used.end.x * tile_size.x
	camera_2d_2.limit_bottom = used.end.y * tile_size.y
	camera_2d_2.limit_left = -used.position.x * tile_size.x
	camera_2d_2.reset_smoothing()

