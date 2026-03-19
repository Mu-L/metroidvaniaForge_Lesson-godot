@tool
@icon("res://general/icons/door.svg")
class_name DoorInteractible
extends Node2D

const DOOR_CRASH_AUDIO = preload("uid://csfqkrs6y48sj")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var door_name : String = ""

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	#connect to switch thru signal
	for s in get_children():
		if s is DoorSwitch :
			s.activated.connect(on_switch_activated)
			if s.is_door_opened :
				on_switch_is_active()
	pass

func on_switch_activated() -> void : 
	#audio playback
	#play the animation open
	Audio.play_spatial_soundfx(DOOR_CRASH_AUDIO,global_position, 0)
	animation_player.play("open")
	pass
	
func on_switch_is_active() -> void :
	#if opened, play the open animation
	animation_player.play("opened")
	pass
	
func _get_configuration_warnings() -> PackedStringArray:
	if check_for_switches() == false :
		return [ "Door Switch node missing."]
	return []

func check_for_switches() -> bool :
	for c in get_children():
		if c is DoorSwitch :
			return true
	return false
