class_name EnemyState extends Node

## Stores a reference to the enemy that this state belongs to
var enemy : Enemy
var state_machine : EnemyStateMachine

## What happens when we initialize this state?
func Init() -> void:
	pass

## what happens when the enemy enter this state?
func Enter() -> void:
	pass

## what happens when the enemy exit the state?
func Exit() -> void:
	pass

## what happens in the _physics update in this State?
func Process( _delta : float) -> EnemyState:
	return null
	

## what happens in the _physics_process update in this State?
func Physics( _delta : float) -> EnemyState:
	return null
