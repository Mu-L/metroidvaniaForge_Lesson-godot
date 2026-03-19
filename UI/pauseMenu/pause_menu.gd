class_name PauseMenu
extends CanvasLayer

#region // onready variables 
@onready var pause_screen: Control = %PauseScreen
@onready var system_screen: Control = %SystemScreen

  
#buttons
@onready var system_menu_button: Button = $Control/PauseScreen/SystemMenuButton

@onready var backto_map_button: Button = %backtoMapButton
@onready var backto_title_button: Button = %backtoTitleButton

#audio sliders
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SoundFx
@onready var ui_slider: HSlider = %UISlider
#var related to audio
var player_pos : Vector2
#endregion

func _ready() -> void:
	#grab player 
	Audio.setup_audio_buttons(self)
	show_pause_screen()
	setup_system_screen()
	var player : Node = get_tree().get_first_node_in_group("Player")
	if player :
		player_pos = player.global_position
	#audio setup
	#system menu
	
	system_menu_button.pressed.connect(show_system_screen)

	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_viewport().set_input_as_handled()
		get_tree().paused = false
		queue_free()
	if pause_screen.visible == true :
		if event.is_action_pressed("right") or event.is_action_pressed("down"):
			system_menu_button.grab_focus()
	pass

func setup_system_screen() -> void :
	
	music_slider.value = AudioServer.get_bus_volume_linear(2)
	sfx_slider.value = AudioServer.get_bus_volume_linear(3)
	ui_slider.value = AudioServer.get_bus_volume_linear(4)
	
	music_slider.value_changed.connect(on_music_slider_changed)
	sfx_slider.value_changed.connect(on_sfx_slider_changed)
	ui_slider.value_changed.connect(on_ui_slider_changed)
	
	backto_map_button.pressed.connect(show_pause_screen)
	backto_title_button.pressed.connect(on_back_to_title_button_pressed)
	pass

func show_pause_screen() -> void :
	pause_screen.visible = true
	system_screen.visible = false
	pass

func show_system_screen() -> void :
	pause_screen.visible = false
	system_screen.visible = true
	backto_map_button.grab_focus()
	pass

func on_back_to_title_button_pressed() -> void :
	#free player
	SceneManager.transition_scene("res://UI/TitleScreen/Title_screen.tscn"
	,"", Vector2.ZERO,"up")
	get_tree().paused = false
	Messages.back_to_title.emit()
	queue_free()
	pass

func on_music_slider_changed(v : float) -> void :
	AudioServer.set_bus_volume_linear(2,v)
	SaveManager.save_configuration()
	pass

func on_sfx_slider_changed(v : float) -> void :
	AudioServer.set_bus_volume_linear(3,v)
	Audio.play_spatial_soundfx(Audio.ui_focus_audio,player_pos)
	SaveManager.save_configuration()
	pass
	
func on_ui_slider_changed(v : float) -> void :
	AudioServer.set_bus_volume_linear(4,v)
	Audio.ui_focus_changed()
	SaveManager.save_configuration()
	pass
