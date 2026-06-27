extends CharacterBody3D
@onready var color_rect: ColorRect = $"../CanvasLayer/ColorRect"
@onready var jump: AudioStreamPlayer = $AudioStreamPlayer
const radius = 0.5
const SPEED = 12
var temp = 0
var free = false
var paused = false
@onready var label: Label = $"../CanvasLayer/Label"
@onready var button: Button = $"../CanvasLayer/Button"
var collider
@onready var label_2: Label = $"../CanvasLayer/Label2"
var collision
const JUMP_VELOCITY = 11
@onready var neck: SpringArm3D = $SpringArm3D
@onready var ball: Node3D = $Ball
@onready var camera_3d: Camera3D = $SpringArm3D/Camera3D
var dir: Vector3 = Vector3.ZERO
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Bgm1.stop()
	if !Bgm2.playing:
		Bgm2.play()
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if !free:
			rotate_y(deg_to_rad(-event.relative.x * 0.4))
			neck.rotate_x(deg_to_rad(-event.relative.y * 0.4))
			neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(-45), deg_to_rad(45))
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("free") and !free and !paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		free = true
	elif Input.is_action_just_pressed("free") and free and !paused:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		free = false
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_front", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed := Vector3(velocity.x,0,velocity.z)
	dir = dir.move_toward(direction,10.0*delta)
	if dir :
		velocity.x = move_toward(velocity.x,dir.x * SPEED, 20.0 * delta)


		velocity.z = move_toward(velocity.z,dir.z * SPEED, 20.0 * delta)
		
	else:
		velocity.x = move_toward(velocity.x, 0, 1.0 * delta)
		velocity.z = move_toward(velocity.z, 0, 1.0 * delta)
	if speed.length():
		temp = delta * speed.length()
		ball.global_rotate(Vector3.UP.cross(speed.normalized()),temp / radius)
	move_and_slide()
	for i in get_slide_collision_count():
		collision = get_slide_collision(i)
		collider = collision.get_collider()
		if collider is RigidBody3D:
			collider.apply_central_impulse(-collision.get_normal() * 5.0)
	if Input.is_action_just_pressed("esc") and !paused:
		stop()
	if Input.is_action_just_pressed("esc") and paused:
		cont()

func _on_button_pressed() -> void:
	stop()
func stop():
	color_rect.show()
	label_2.hide()
	label.hide()
	Engine.time_scale = 0.0
	button.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	free = true
func cont():
	color_rect.hide()
	label_2.show()
	label.show()
	Engine.time_scale = 1.0
	button.show()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	free = false

func _on_button_2_pressed() -> void:
	Engine.time_scale = 1.0
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	

func _on_button_3_pressed() -> void:
	cont()
