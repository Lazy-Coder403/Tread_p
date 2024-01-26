extends VehicleBody3D

@export var max_steer = 0.8
@export var max_rpm = 300

@onready var camera_pivot = $Camera_pivot
@onready var front_camera = $Camera_pivot/Front_Camera
@onready var reverse_camera = $Camera_pivot/Reverse_Camera


var default_view
var default_axis_x = 0.0
var default_steer_rate = 2.25

func _ready():
	default_view = global_position

func _input(_ev):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Main/Scenes/menu.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	steering = move_toward(steering, Input.get_axis("ui_right", "ui_left") * max_steer, delta * default_steer_rate)
	
	engine_force = Input.get_axis("ui_down", "ui_up") * 300
	camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 20.0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
	default_view = default_view.lerp(global_position + linear_velocity, delta * default_axis_x)
	front_camera.look_at(default_view)
	_check_camera_switch()
#func _vary_steer_rate():
	
	
func _check_camera_switch():
	if linear_velocity.dot(transform.basis.z) > 0:
			default_axis_x = 5.0
	else:
		default_axis_x = 0.5
	
	if Input.is_action_pressed("ui_select") != true:
		front_camera.current = true
	else:
		reverse_camera.current = true
		
