class_name LadderEnter
extends PlayerState

var entered_from_top : bool = false
var entered_from_below :bool = false
var entered_from_fall : bool = false
var duration = 0
func init() -> void:
	pass
	
func enter() -> void:
	duration = 0
	check_ladder_entry_direction()
	ladder_entry_properties()
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = true
	player.collision_ledge.disabled = true
	player.gravity_multiplier = 0
	duration = player.animation_player.current_animation_length
	pass

func exit() -> void:
	entered_from_top = false
	entered_from_below = false
	entered_from_fall = false
	duration = 0
	pass

func handle_input( _event : InputEvent ) -> PlayerState :
	return null

func process(_delta: float) -> PlayerState:
	if entered_from_top :
		player.position.y += 1.6
		
	elif entered_from_below or entered_from_fall:
		player.position.y -= 1.6

		
	if not player.animation_player.is_playing():
		return climb_ladder
		
	return null

func physics_process(_delta: float) -> PlayerState:
	return null
	
func check_ladder_entry_direction() -> void :
	var direction := Input.get_axis("up", "down")
	
	if not player.is_on_floor():
		entered_from_fall = true
		
	if direction > 0 and player.is_on_floor():
		entered_from_top = true
	else:
		entered_from_below = true 
	pass

func ladder_entry_properties():
	if entered_from_top :
		player.animation_player.play("ladderentertop")
	
	elif entered_from_below :
		#fix later with player grabbing ladder when entering from below or on air
		player.animation_player.play("ladderenterbelow")
		
	else : 
		player.animation_player.play("ladderenterair")
	
