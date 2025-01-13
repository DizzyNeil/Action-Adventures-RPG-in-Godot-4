class_name EnemyStateDestroy extends EnemyState


@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

var _damage_position : Vector2
var _direction : Vector2

## What happens when we initialize this state?
func Init() -> void:
	enemy.enemy_destroyed.connect( _on_enemy_destroyed )
	pass

## what happens when the enemy enter this state?
func Enter() -> void:
	enemy.Invulnarable = true
	_direction = enemy.global_position.direction_to( _damage_position )
	
	enemy.set_direction( _direction )
	enemy.velocity = _direction * -knockback_speed
	
	enemy.update_animation( anim_name )
	enemy.animation_player.animation_finished.connect( _on_animation_finished )
	pass

## what happens when the enemy exit the state?
func Exit() -> void:
	enemy.Invulnarable = false
	enemy.animation_player.animation_finished.disconnect( _on_animation_finished )
	pass

## what happens in the _physics update in this State?
func process( _delta : float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

## what happens in the _physics_process update in this State?
func Physics( _delta : float) -> EnemyState:
	return null

func _on_enemy_destroyed( hurt_box : HurtBox ) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state( self )

func _on_animation_finished( _a : String ) -> void:
	enemy.queue_free()
