class_name PlayerCamera
extends Camera2D

var shakestr : float = 0 
@export var shakedecayrate : float = 5.0
@export var maxshakeoffset : float = 20.0

var camlimit_left : float
var camlimit_right : float
var camlimit_top : float
var camlimit_bottom : float
var is_boss_area : bool = false

func _ready() -> void:
	Visualfx.camera_shake.connect(apply_shake)
	SceneManager.new_scene_ready.connect(_on_scene_transition)
 
func _process(delta: float) -> void:
	offset = Vector2 ( 
		randf_range(-shakestr , shakestr),
		randf_range(-shakestr , shakestr))
		
	shakestr = lerp(shakestr , 0.0 , shakedecayrate * delta)
func apply_shake(strength :float) -> void:
	shakestr = min(strength , maxshakeoffset)
	
	pass

func _on_scene_transition (_t , _o) -> void :
	reset_smoothing.call_deferred()
	pass

func resize_area_if_boss_battle(cl:float,cr:float,ct:float,cb:float,boss_area : bool) -> void :
	print("Received limits:", cl, cr, ct, cb , boss_area)
	
	limit_left = int(cl) 
	limit_right = int(cr)
	limit_top = int(ct)
	limit_bottom = int(cb)
	is_boss_area = boss_area
	print("Limit Left :" , limit_left," Limit Right :", limit_right, 
	" Limit Top : " , limit_top," Limit Bottom : " , limit_bottom)
	pass
	
