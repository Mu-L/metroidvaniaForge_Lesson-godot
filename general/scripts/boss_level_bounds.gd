@tool
@icon ("res://general/icons/level_bounds.svg")
class_name BossLevelBounds
extends Node2D

@export_range(480, 2048, 32) var boss_width := 480:
	set(value):
		boss_width = value
		queue_redraw()

@export_range(270, 2048, 32) var boss_height := 270:
	set(value):
		boss_height = value
		queue_redraw()
		
var player_in_boss_area : bool = false

func _ready() -> void:
	z_index = 256
	if Engine.is_editor_hint():
		return
	
	#SceneManager.boss_camera_limits.emit( int(global_position.x ) , int(global_position.x) + width ,
	#int(global_position.y) , int(global_position.y) + height)
	
	pass
func _draw() -> void:
	if Engine.is_editor_hint():
		#draw a box 
		var br := Rect2(Vector2.ZERO, Vector2(boss_width, boss_height))
		draw_rect(br, Color(1.0, 0.0, 0.086, 0.6), false,4)
		draw_rect(br, Color(1.0, 0.0, 0.025, 1.0), false,1)
		pass
	pass

func on_width_change(nw : int) -> void :
	boss_width = nw
	queue_redraw()
	pass

func on_height_change(nh : int) -> void :
	boss_height = nh
	queue_redraw()
	pass
