class_name HitBox extends Area2D

signal Damaged( hurt_box : HurtBox )

func TakeDamage( hurt_box : HurtBox ) -> void:
	print( "Take Damage: ", hurt_box )
	Damaged.emit( hurt_box )
