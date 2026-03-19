class_name DashState
extends PlayerState

#create a dash timer using float 
#create dash time / used as default value on how long player can dash
@export var dashDuration : float = 0.2 #how long player can dash
@export var dashvelocity : float = 800

@onready var slideTimer : Timer

var origdashDuration : float = 0

	
func enter() -> void:
	origdashDuration = dashDuration
	#create custom timer 
	slideTimer = Timer.new()
	pass
	
func process(delta: float) -> PlayerState:
	dashDuration -= delta
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if dashDuration > 0 :
		player.velocity.y  = 0
		if player.sprite_2d.flip_h :
			player.velocity.x = -dashvelocity
		else :
			player.velocity.x = dashvelocity
	else :
		if player.is_on_floor():
			return idle
		else:
			return fall
			
	return next_state
	
func exit() -> void:
	dashDuration = origdashDuration
	pass

func begin_player_dash(dashdur : float)-> void :
	slideTimer.wait_time = dashdur
	slideTimer.one_shot = true

func end_player_dash()-> void :
	return slideTimer.is_stopped()
