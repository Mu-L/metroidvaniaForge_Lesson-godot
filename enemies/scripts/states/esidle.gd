class_name ESIdle
extends EnemyState



func enter() -> void :
	var anim : String = animation_name if animation_name else "Idle"
	enemy.play_animation(anim)
	enemy.velocity.x = 0
	pass

func re_enter() -> void :
	#when enemy re-enter same state
	pass

func exit() -> void :
	#when enemy moves to next state
	pass

func physics_update(_delta: float) -> void:
	#physics related variables here
	pass
