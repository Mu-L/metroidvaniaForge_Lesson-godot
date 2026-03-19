extends Node2D

@export var particles : Array [HitParticlesSettings]  
@export var basewobbleangle : float = 4.0
@export var wobblespeed : float = 0.1

var wobblecount : int = 0
var tween : Tween
@onready var body: Sprite2D = $body
@onready var damage_area: DamageArea = $DamageArea

func _ready() -> void:
	damage_area.damage_taken.connect(on_damage_taken)
	

func on_damage_taken (attack_area : AttackArea) -> void :
	var dir : float = 1.0
	if attack_area.global_position.x > global_position.x :
		dir = -1
	
	var pos : Vector2 = global_position + Vector2(0 , -30)
	for p in particles :
		Visualfx.hit_particles( pos , Vector2(dir , 0) , p)
	
	wobblecount = 5
	wobble(dir)
	pass

func wobble(dir : float) -> void :
	if tween :
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property( body ,
					"rotation_degrees" , 
					basewobbleangle * wobblecount * dir , 
					wobblespeed * 0.5)
	while wobblecount > 0 :
		dir *= -1
		wobblecount -= 1
		tween.tween_property( body ,
					"rotation_degrees" , 
					basewobbleangle * wobblecount * dir , 
					wobblespeed)
		pass
	
	pass
