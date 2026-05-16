class_name ESHurt
extends EnemyState

@export var knockbackstrength : float = 100
var velx : float = 0
var duration : float = 0
var timer : float = 0
var attackdirection : float = 0 

func start() -> void :
	var anim : String = animation_name if animation_name else "hurt"
	if enemy.animation.current_animation == anim :
		enemy.animation.seek(0)
	else :
		enemy.play_animation(anim)
	duration = enemy.animation.get_animation(anim).length

	timer = 0
	calculate_velocity(blackboard.damage_source)
	attackdirection = sign(
	blackboard.damage_source.global_position.x
	- enemy.global_position.x)
	_check_for_back_attack()
	blackboard.damage_source = null
	blackboard.can_decide = false
	pass

func enter() -> void :
	start()
	#when enemy enters this state
	pass

func re_enter() -> void :
	start()
	#when enemy re-enter same state
	pass

func exit() -> void :
	blackboard.damage_source = null
	blackboard.can_decide = true
	pass

func physics_update(delta: float) -> void:
	#physics related variables here
	timer += delta
	enemy.velocity.x = velx * (1 - timer/duration)
	if timer >= duration :
		blackboard.can_decide = true
	pass
	
func calculate_velocity(a : AttackArea) -> void :
	velx = 1
	if a.global_position.x > enemy.global_position.x :
		velx = -1
	velx *= knockbackstrength
	pass

func _check_for_back_attack() -> void : 
	if attackdirection < 0 :
		enemy.change_direction(attackdirection)
	pass
 
