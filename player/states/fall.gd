extends PlayerState
class_name PlayerStateFall

@export var fall_gravity_multiplier : float = 1.165
@export var coyoteTime: float = 0.125
@export var jumpBufferTime : float = 0.22

var coyoteTimer : float = 0
var bufferTimer : float = 0
var playerHasDoubleJumped : bool = false
 
func init() -> void:
	pass
	
func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	
	player.gravity_multiplier = fall_gravity_multiplier #increases gravity fall velocity during fall
	if player.previous_state == jump || player.previous_state == attack :
		coyoteTimer = 0
	else :
		coyoteTimer = coyoteTime
	pass

func exit() -> void:
	
	bufferTimer = 0
	player.gravity_multiplier = 1.0 # reset gravity to default
	
 
	pass

func handle_input( event : InputEvent ) -> PlayerState :
	if event.is_action_pressed("attack"):
		return attack
		
	if event.is_action_pressed("jump"):
		if coyoteTimer > 0:
			return jump
		elif playerHasDoubleJumped == false and player.double_jump : 
			playerHasDoubleJumped = true
			return jump
		else :
			bufferTimer = jumpBufferTime
	if event.is_action_pressed("dash"):
		return dash
		
	return next_state

func process(delta: float) -> PlayerState:
	coyoteTimer -= delta
	bufferTimer -= delta
	set_fall_frame()
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		playerHasDoubleJumped = false
		Visualfx.create_land_dust_fx(player.global_position)
		#player.add_debugger(Color.DARK_BLUE)
		#Audio.play_spatial_soundfx(LANDDOWNSFX ,player.global_position , -3 , -11)
		player.land_sfx.play()
		if bufferTimer > 0 :
			return jump
		
		return idle
	player.velocity.x = player.direction.x * player.movespeed
	return next_state

func set_fall_frame() -> void:
	var frame : float = remap(player.velocity.y ,0.0,player.maxfallspeed,0.5,1.0)
	player.animation_player.seek( frame , true )
	pass

 
