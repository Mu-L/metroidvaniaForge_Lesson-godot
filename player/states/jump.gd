extends PlayerState
class_name PlayerStateJump

@export var jumpvelocity : float = 450

#@export var jumpmovespeed : float = 150

func init() -> void:
	pass
	
func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	
	#player.add_debugger(Color.FOREST_GREEN)
	player.velocity.y = 0
	player.velocity.y = -jumpvelocity
	
	#check if buffer timer is triggered
	if player.previous_state == fall and not Input.is_action_pressed("jump"):
		await get_tree().physics_frame
		player.velocity.y *= 0.5
		player.change_state(fall) # manually change to fall because we cant return a state in the enter function
	pass

func exit() -> void:
	#player.add_debugger(Color.YELLOW)
	pass

func handle_input( event : InputEvent ) -> PlayerState :
	if event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state

func process(_delta: float) -> PlayerState:
	set_jump_frame()
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
		
	elif player.velocity.y >= 0 : 
		return fall
	
	player.velocity.x = player.direction.x * player.movespeed
	return next_state

func set_jump_frame() -> void:
	var frame : float = remap(player.velocity.y ,-jumpvelocity ,0.0,0.0,0.5)
	player.animation_player.seek( frame , true )
	pass
