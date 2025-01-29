class_name PresistentDataHandler extends Node2D

signal data_loaded
var value : bool = false 

func _ready() -> void:
	get_value()
	pass


func set_value() -> void:
	GlobalSaveManager.add_presistent_value( _get_name() )


func get_value() -> void:
	value = GlobalSaveManager.check_presistent_value( _get_name() )
	data_loaded.emit()


func _get_name() -> String:
	return get_tree().current_scene.scene_file_path + "/" + get_parent().name + "/" + name
