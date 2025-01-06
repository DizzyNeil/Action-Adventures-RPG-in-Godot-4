class_name PlayerCamera extends Camera2D

func _ready() -> void:
	LevelManager.TileMapBoundsChange.connect( UpdateLimit )
	UpdateLimit( LevelManager.current_tilemap_bounds )
	pass

func UpdateLimit( bounds : Array[ Vector2 ] ) -> void:
	if bounds == []:
		return
	limit_left = int( bounds[0].x )
	limit_top = int( bounds[0].y )
	limit_right = int( bounds[1].x )
	limit_bottom = int( bounds[1].x )
	pass
