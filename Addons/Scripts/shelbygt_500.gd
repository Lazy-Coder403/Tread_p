extends VehicleBody3D

@export var max_steer = 0.8
@export var max_rpm = 300

var default_view
var default_steer_rate = 2.25

func _ready():
	pass

func _input(_ev):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Main/Scenes/menu.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	steering = move_toward(steering, Input.get_axis("ui_right", "ui_left") * max_steer, delta * default_steer_rate)
	engine_force = Input.get_axis("ui_down", "ui_up") * 300
