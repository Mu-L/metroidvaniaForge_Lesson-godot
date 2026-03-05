extends PlayerState
class_name PlayerStateIdle

func init() -> void:
	pass
	
func enter() -> void:
	player.animation_player.play("idle")
	pass

func exit() -> void:
	pass

func handle_input( _event : InputEvent ) -> PlayerState :
	if _event.is_action_pressed("jump"):
		return jump
	
	#if _event.is_action_pressed("down") and player.is_on_floor():
		#return crouch
		
	return next_state

func process(_delta: float) -> PlayerState:
	if player.direction.x != 0 :
		return run
	elif player.direction.y > 0.5 :
		return crouch
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = 0
	if player.is_on_floor():
		#player.add_debugger(Color.DARK_BLUE)
		return idle
	return next_state
