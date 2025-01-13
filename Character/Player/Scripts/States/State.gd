class_name State extends Node

## store a reference to the player where it belongs too, i guess
static var player: Player
static var state_machine : PlayerStateMachine

func _ready() -> void:
	pass

## What happens when we initialize this state?
func Init() -> void:
	pass

## what happens when the player enter this state?
func Enter() -> void:
	pass

## what happens when the player exit the state?
func Exit() -> void:
	pass

## what happens in the _physics update in this State?
func Process( _delta : float) -> State:
	return null
	

## what happens in the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null

## what happen with the inputevent during the State?
func HandleInput( _event : InputEvent) -> State:
	return null
