class_name ClimbLadder
extends PlayerState

@export var climbSpeed : float = 120
var knockbackdirection : float = 1.0
var duration 
var entered_from_top : bool = false
var exit_from_top : bool = false
var entered_ladder : bool = false

func init() -> void:
	pass
	
func enter() -> void:
	player.collision_stand.set_deferred("disabled", true)
	player.collision_crouch.set_deferred("disabled", true)
	player.collision_ledge.set_deferred("disabled", true)
	player.gravity_multiplier = 0
	entered_ladder = true
	handle_ladder_properties()
	
	pass

func exit() -> void:
	player.damage_area_stand.disabled = true
	player.damage_area_crouch.disabled = false
	pass

func handle_input( _event : InputEvent ) -> PlayerState :
	if _event.is_action_released("down"):
		player.velocity.y = 0
		player.gravity_multiplier = 0
	return null

func process(_delta: float) -> PlayerState:
	if not player.is_on_ladder and entered_from_top:
		player.velocity.y = climbSpeed
	
	
	#this is the idle state in ladder
	if player.is_on_ladder : 
		player.velocity.y = 0 
		player.gravity_multiplier = 0
		
	if player.is_on_ladder and player.direction.y > 0.5 and not player.can_exit_top_ladder:
		handle_ladder_properties()

	if player.is_on_ladder and player.direction.y < -0.5 and not player.can_exit_top_ladder:
		handle_ladder_properties()

	if player.can_exit_top_ladder:
		handle_ladder_properties()


	return null

func physics_process(_delta: float) -> PlayerState:
	return null

func handle_ladder_properties() -> void :
	#entrance to ladder from above
	if player.player_on_top_of_ladder and not player.is_on_ladder:
		player.animation_player.play("ladderenter")
		entered_from_top = true
		duration = player.animation_player.current_animation_length
		player.position.y += 12
	
	#while within ladder
	if player.is_on_ladder and not player.can_exit_top_ladder : 
		if ( player.direction.y > 0.5 ) :
			player.velocity.y = climbSpeed
		if ( player.direction.y < 0.5 ) :
			player.velocity.y = -climbSpeed
		player.animation_player.play("ladderclimb")
		pass
	
	#exit ladder from above
	if player.can_exit_top_ladder and not exit_from_top:
		player.animation_player.play("ladderexit")
		player.position.y -=13
		exit_from_top = true
		pass
	pass

func handle_ladder_direction() -> void :
	pass
