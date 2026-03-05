extends PlayerState
class_name PlayerStateRun



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
	if _event.is_action_pressed("jump"):
		return jump
	return next_state

func process(_delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.movespeed
	
	if player.is_on_floor() == false:
		return fall
	return next_state
