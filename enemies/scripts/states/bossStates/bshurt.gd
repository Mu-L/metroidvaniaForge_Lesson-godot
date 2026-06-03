class_name BSHurt
extends EnemyState

@export var knockbackstrength : float = 100


var velx : float = 0
var duration : float = 0
var timer : float = 0
var attackdirection : float = 0 
var punish_hit : int = 0 

func start() -> void :
	var anim : String = animation_name if animation_name else "Hurt"

	if enemy.animation.current_animation == anim :
		enemy.animation.seek(0)
	else :
		enemy.play_animation(anim)
	#calculate_velocity(blackboard.damage_source)
	duration = enemy.animation.get_animation(anim).length
	timer = 0
	attackdirection = sign(
	blackboard.damage_source.global_position.x
	- enemy.global_position.x)
	blackboard.damage_source = null
	blackboard.can_decide = false

	if !enemy.damage_counter.is_connected(_on_enemy_punished):
		enemy.damage_counter.connect(_on_enemy_punished)
	pass

func enter() -> void :
	start()
	pass

func re_enter() -> void :
	start()
	pass

func exit() -> void :
	reset_punish_parameters()
	check_for_back_attack()
	blackboard.damage_source = null
	blackboard.can_decide = true
	pass

func physics_update(delta: float) -> void:
	#physics related variables here
	timer += delta
	enemy.velocity.x = velx * (1 - timer/duration)
	if punish_hit > 0 :
		blackboard.can_retaliate = true 
	if timer >= duration :
		blackboard.can_decide = true
		blackboard.punishattack = false
		blackboard.just_attacked = false
	pass
	
func calculate_velocity(a : AttackArea) -> void :
	velx = 1
	if a.global_position.x > enemy.global_position.x :
		velx = -1
	velx *= knockbackstrength
	pass

func check_for_back_attack() -> void : 
	enemy.change_direction(attackdirection)
	pass
 
func reset_punish_parameters() -> void :
	blackboard.can_decide = true
	blackboard.punishattack = false
	blackboard.just_attacked = false
	punish_hit = 0
	pass
	
func _on_enemy_punished() -> void :
	punish_hit += 1 
	pass
