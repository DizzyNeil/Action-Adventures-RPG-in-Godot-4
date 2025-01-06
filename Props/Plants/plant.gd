class_name Plant extends Area2D


func _ready() -> void:
	$Hitbox.Damaged.connect( TakeDamage )


func TakeDamage( _damage : int ) -> void:
	queue_free()
