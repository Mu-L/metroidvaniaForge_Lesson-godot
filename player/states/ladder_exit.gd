class_name LadderExit
extends PlayerState

var exit_top : bool = false
var exit_below :bool = false
var entered_ladder : bool = false
var exit_air : bool = false
var duration = 0
func init() -> void:
	pass
	
func enter() -> void:
	#player.collision_stand.disabled = true
	#player.collision_crouch.disabled = true
	#player.collision_ledge.disabled = true
	#duration = 0
	duration = 0
	print("Entered ladder exit state")
	ladder_animation_properties()
	duration = player.animation_player.current_animation_length
	pass

func exit() -> void:
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	player.collision_ledge.disabled = true
	player.gravity_multiplier = 1
	exit_top = false 
	exit_below = false
	exit_air = false
	duration = 0
	pass

func handle_input( _event : InputEvent ) -> PlayerState :
	return null

func process(delta: float) -> PlayerState:
	duration -= delta
	
	if not player.animation_player.is_playing():
		player.velocity.y = 0
		duration = 0
		return idle

	return null

func physics_process(_delta: float) -> PlayerState:
	return null
	
func check_ladder_exit_direction(exit_dir : String = "") -> void :
	var d = exit_dir
	print("Exit direction : " , d)
	if d == "exit_top" :
		exit_top = true
		exit_below = false
		
	elif d == "exit_bottom":
		exit_top = false
		exit_below = true
	pass

func ladder_animation_properties() -> void :
	if exit_top :
		player.animation_player.play("ladderexittop")
	
	if exit_below :
		player.animation_player.play("ladderexitbelow")
	pass
