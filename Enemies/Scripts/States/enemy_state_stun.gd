class_name EnemyStateStun extends EnemyState


@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : EnemyState

var _direction : Vector2
var _animation_finished : bool = false

## What happens when we initialize this state?
func Init() -> void:
	enemy.enemydamaged.connect( _on_enemy_damaged )
	pass

## what happens when the enemy enter this state?
func Enter() -> void:
	_animation_finished = false
	#_direction = enemy.DIR_4[ rand ]
	
	enemy.set_direction( _direction )
	enemy.velocity = _direction * -knockback_speed
	
	enemy.update_animation( anim_name )
	pass

## what happens when the enemy exit the state?
func Exit() -> void:
	pass

## what happens in the _physics update in this State?
func process( _delta : float) -> EnemyState:
	if _animation_finished == true:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

## what happens in the _physics_process update in this State?
func Physics( _delta : float) -> EnemyState:
	return null

func _on_enemy_damaged() -> void:
	state_machine.change_state( self )
