class_name State_Attack extends State

var attacking: bool = false

@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation: AnimationPlayer = $"../../PlayerSprite/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurtbox: HurtBox = $"../../Interations/Hurtbox"

@export var attack_sound : AudioStream
@export_range(1, 20, 0.5) var decelerate_speed : float = 5.0

## what happens when the player enter this state?
func Enter() -> void:
	player.update_animation("attack")
	attack_animation.play("attack_" + player.anim_direction())
	animation_player.animation_finished.connect( EndAttack )
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	
	attacking = true
	
	await get_tree().create_timer( 0.075 ).timeout
	if attacking:
		hurtbox.monitoring = true

## what happens when the player exit the state?
func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack )
	attacking = false
	hurtbox.monitoring = false

## what happens in the _physics update in this State?
func Process( _delta : float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

## what happens in the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null

## what happen with the inputevent during the State?
func HandleInput( _event : InputEvent) -> State:
	return null

func EndAttack( _newAnimName : String ) -> void:
	attacking = false
