extends PlayerState
class_name PlayerStateRun


var foot_step_played : bool = false


#region preloaded audio
const FOOTSTEP1 = preload("uid://b3diyo26xdaah")
const FOOTSTEP2 = preload("uid://b1y6rfnri83vk")
const FOOTSTEP3 = preload("uid://bddhaxqxpxwym")

const FOOTSTEPS = [FOOTSTEP1, FOOTSTEP2, FOOTSTEP3]

#endregion

func init() -> void:
	pass
	
func enter() -> void:
	#play animation
	#call this function whenver you enter a new state
	
	player.animation_player.play("run")
	pass

func exit() -> void:
	pass

func handle_input( _event : InputEvent ) -> PlayerState :
	if _event.is_action_pressed("attack"):
		return attack
		
	if _event.is_action_pressed("jump"):
		return jump
	
	if _event.is_action_pressed("dash"):
		return dash
		
	return next_state

func process(_delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.movespeed
	
	if (player.sprite_2d.frame == 14 
	or player.sprite_2d.frame == 17
	or player.sprite_2d.frame == 13):
		randomize_footstep_sfx()
	else :
		foot_step_played = false
		
	if player.is_on_floor() == false:
		return fall
	return next_state
	
func randomize_footstep_sfx() -> void :
	if !foot_step_played :
		var fs = FOOTSTEPS.pick_random()
		#Audio.play_spatial_soundfx(fs ,player.global_position , -3 , -6)
		player.footstep_sfx.stream = fs
		player.footstep_sfx.play()
		foot_step_played = true
	pass
	
