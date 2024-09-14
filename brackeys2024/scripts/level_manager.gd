extends Node

var game_running:bool = false
var pause = preload("res://ui/pause.tscn")
var ui = preload("res://ui/in_game_ui.tscn")
var in_game_ui
var levels:Dictionary = {1:{"scene":"res://scenes/map_1.tscn","timer":12}}
@onready var viewport_width: float = ProjectSettings.get_setting("display/window/size/viewport_width")
@onready var viewport_height: float = ProjectSettings.get_setting("display/window/size/viewport_height")
var pause_menu

func start_level(level):
	get_tree().change_scene_to_file(levels[level]["scene"])
	StageTimer.end_stage_time = levels[level]["timer"]
	game_running = true
	in_game_ui = ui.instantiate()
	pause_menu = pause.instantiate()
	add_child(in_game_ui)
	in_game_ui.size = Vector2(viewport_width,viewport_height)
	add_child(pause_menu)
	StageTimer.start_timer()

func _process(delta):
	if Input.is_action_pressed("ui_cancel") and game_running == true:
		pause_menu.panel.visible = true
		StageTimer.pause_timer(true)
		get_tree().paused = true

func quit():
	in_game_ui.queue_free()
