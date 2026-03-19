class_name DustEffect
extends Sprite2D

enum TYPE { jump , land , hit}
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start_effect (type : TYPE) -> void:
	var anim_name : String = "jump"
	
	match type :
		TYPE.jump :
			position.y -= 14
		TYPE.land :
			anim_name = "land"
			position.y -= 14
		TYPE.hit :
			anim_name = "hit"
			rotation_degrees = randi_range(0,3) * 90
			pass
	animation_player.play(anim_name)
	await animation_player.animation_finished
	queue_free()
	pass
