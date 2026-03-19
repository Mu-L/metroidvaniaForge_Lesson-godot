@icon("res://general/icons/music_trigger.svg")
class_name MusicTrigger
extends Node

@export var track : AudioStream
@export var reverb : Audio.REVERB_TYPE = Audio.REVERB_TYPE.none
@export var volumeoverride : float = 0

func _ready() -> void:	
	Audio.play_music(track)
	Audio.set_reverb(reverb)
	Audio.music_1.volume_db = volumeoverride
	pass
	
