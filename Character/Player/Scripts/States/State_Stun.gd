class_name State_Stun extends State

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

var hurtbox : HurtBox
var direction : Vector2

var next_state : State = null

@onready var idle: State = $"../Idle"

## What start the state
func Init() -> void:
	player.player_damaged.connect( player_damaged )

## what happens when the player enter this state?
func Enter() -> void:
	player.animation_player.animation_finished.connect( _animation_finished )
	
	direction = player.global_position.direction_to( hurtbox.global_position )
	player.velocity = direction * -knockback_speed
	player.set_direction()
	
	player.update_animation("stun")
	player.make_invulnarable( invulnerable_duration )
	player.effect_animation_player.play("damaged")
	pass

## what happens when the player exit the state?
func Exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect( _animation_finished )
	pass

## what happens in the _physics update in this State?
func Process( _delta : float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state

## what happens in the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null

## what happen with the inputevent during the State?
func HandleInput( _event : InputEvent) -> State:
	return null

func player_damaged( _hurtbox : HurtBox ) -> void:
	hurtbox = _hurtbox
	state_machine.ChangeState( self )
	pass

func _animation_finished( _a : String ) -> void:
	next_state = idle
