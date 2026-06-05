class_name PlayerCamera
extends Camera2D

var shakestr : float = 0 
@export var shakedecayrate : float = 5.0
@export var maxshakeoffset : float = 20.0
@export var zoom_duration : float = 0
@export var zoom_value := Vector2(0,0)
@export var boss_cam_duration : float = 0
@export var boss_cam_pos : float = 0
var camlimit_left : float
var camlimit_right : float
var camlimit_top : float
var camlimit_bottom : float
var is_boss_area : bool = false

func _ready() -> void:
	Visualfx.camera_shake.connect(apply_shake)
	SceneManager.new_scene_ready.connect(_on_scene_transition)
	SceneManager.boss_area_limits.connect(resize_area_if_boss_battle)
	
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

func resize_area_if_boss_battle(cl:float,cr:float,ct:float,cb:float,centercam:float) -> void :
	limit_left = int(cl) 
	limit_right = int(cr)
	limit_top = int(ct)
	limit_bottom = int(cb)
	boss_cam_pos = centercam
	await pan_camera_function()
	await get_tree().process_frame
	await zoom_out_camera()
	await get_tree().process_frame

	print("Limit Left :" , limit_left," Limit Right : ", limit_right, 
	" Limit Top : " , limit_top," Limit Bottom : " , limit_bottom , " Viewport Size : ",zoom)
	pass
	
func zoom_out_camera() -> Signal :
	var tween : Tween = create_tween()
	print("Zoom Out Camera : " , zoom_value , " : " , zoom_duration , " Original zoom value : " , zoom)
	tween.tween_property(self ,"zoom", zoom_value,zoom_duration)
	return tween.finished
 
func pan_camera_function() -> Signal :
	var tween : Tween = create_tween()
	tween.tween_property(self ,"global_position:x", boss_cam_pos,boss_cam_duration)
	return tween.finished
