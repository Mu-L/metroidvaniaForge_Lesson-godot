class_name PlayerCamera
extends Camera2D

var shakestr : float = 0 
@export var shakedecayrate : float = 5.0
@export var maxshakeoffset : float = 20.0

func _ready() -> void:
	Visualfx.camera_shake.connect(apply_shake)

func _process(delta: float) -> void:
	offset = Vector2 ( 
		randf_range(-shakestr , shakestr),
		randf_range(-shakestr , shakestr))
	
	shakestr = lerp(shakestr , 0.0 , shakedecayrate * delta)
func apply_shake(strength :float) -> void:
	shakestr = min(strength , maxshakeoffset)
	
	pass
