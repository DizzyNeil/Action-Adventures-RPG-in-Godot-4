class_name State_Idle extends State

@onready var walk : State = $"../Walk"
@onready var attack: State = $"../Attack"

## what happens when the player enter this state?
func Enter() -> void:
	player.update_animation("idle")

## what happens when the player exit the state?
func Exit() -> void:
	pass

## what happens in the _physics update in this State?
func Process( _delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

## what happens in the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null

## what happen with the inputevent during the State?
func HandleInput( _event : InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
