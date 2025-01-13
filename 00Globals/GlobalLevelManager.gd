extends Node

signal level_load_started
signal level_loaded
signal TileMapBoundsChange( bounds : Array[ Vector2 ] )

var current_tilemap_bounds : Array[ Vector2 ]
var target_transition : String
var position_offset :Vector2


func ChangeTileMapBounds( bounds : Array[ Vector2 ] ) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChange.emit( bounds )

func load_new_level(
		level_path : String,
		_target_transition : String,
		_position_offset : Vector2
) -> void:
	
	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset
	
	await get_tree().process_frame ## Level Transition
	
	level_load_started.emit()
	
	await get_tree().process_frame
	
	get_tree().change_scene_to_file( level_path )
	
	await get_tree().process_frame
	
	get_tree().paused = false
	
	await get_tree().process_frame
	
	level_loaded.emit()
	pass
