class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var invulnarable : bool = false
var hp : int = 6
var max_hp : int = 6

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hitbox: HitBox = $Hitbox

signal DirectionChanged( new_direction : Vector2 )
signal player_damaged( hurt_box : HurtBox )

func _ready() -> void:
	PlayerManager.player = self 
	state_machine.Initialize(self)
	hitbox.Damaged.connect( _take_damage )
	update_hp(99)

func  _process(_delta: float) -> void:
	
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up") 
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
 
func _physics_process(_delta: float) -> void:
	move_and_slide()

func set_direction() -> bool:
	var new_direction: Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_direction == cardinal_direction:
		return false
	
	
	cardinal_direction = new_direction
	DirectionChanged.emit( new_direction )
	player_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func update_animation( state : String ) -> void:
	
	animation_player.play(state + "_" + anim_direction())
	pass

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage( hurtbox : HurtBox ) -> void:
	if invulnarable == true:
		return
	update_hp( -hurtbox.damage )
	if hp > 0:
		player_damaged.emit( hurtbox )
	else:
		player_damaged.emit( hurtbox )
		update_hp(99)
	pass

func update_hp( delta : int ) -> void:
	hp = clampi( hp + delta, 0, max_hp )
	PlayerHud.update_hp( hp, max_hp )
	pass

func make_invulnarable( _duration : float = 1.0 ) -> void:
	invulnarable = true
	hitbox.monitoring = false
	
	await get_tree().create_timer( _duration ).timeout
	
	invulnarable = false
	hitbox.monitoring = true
	pass
