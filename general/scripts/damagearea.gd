@icon("res://general/icons/damage_area.svg")
class_name DamageArea
extends Area2D 

signal damage_taken(attackarea)
@export var audio : AudioStream


func _ready() -> void:
	pass
	
func take_damage(attackarea : AttackArea) -> void :
	damage_taken.emit(attackarea)
	if audio :
		Audio.play_spatial_soundfx(audio,global_position ,0 , -3)
	pass

#func make_invulnerable(dur : float = 1.0) -> void :
	#process_mode = Node.PROCESS_MODE_DISABLED
	#await get_tree().create_timer(dur).timeout
	#process_mode = Node.PROCESS_MODE_INHERIT
	#pass
