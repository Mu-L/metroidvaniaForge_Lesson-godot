class_name DecisionEngineAxeBoss
extends DecisionEngine

@export var state_attack : BSAttack
@export var state_chase : ESChase
@export var state_idle : ESIdle
@export var attack_distance : float = 40

@onready var es_move: ESMove = %ESMove
@onready var es_hurt: ESHurt = %ESHurt
@onready var es_death: ESDeath = %ESDeath


func _ready() -> void:
	await super()
	pass

func decide() -> EnemyState :
	#example 
	if blackboard.damage_source :
		if blackboard.health <= 0 :
			return es_death 
		else:
			return es_hurt 
	if current_state is ESDeath or not blackboard.can_decide :
		return null
		
	if blackboard.target :
		if state_attack.can_attack():
			return state_attack
	#			if attacktype is normal ( downward axe swing )
	#				return to idle state for a while 
	#               knockback player 
	#			if attacktype is kick 
	#				knockback player further away
	#			if attacktype is heavy ( stronger axe swing with danger indication )
	#				if hit - knockback player 
	#				if missed - transition to recovery state.
	#               	in recovery state there is punish window 
	#               	if player is still within target range after punish window ends
	#						transition to attack (upward swing)
	#							if hit - launch player upwards 
	#					if player is outside target area, return to idle
						  
	#	else :
	#		return es_chase
	return es_move
