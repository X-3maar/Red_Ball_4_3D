extends CharacterBody3D

const radius = 0.5
const SPEED = 8
var temp = 0
const JUMP_VELOCITY = 10
@onready var neck: SpringArm3D = $SpringArm3D
@onready var ball: Node3D = $Ball
@onready var camera_3d: Camera3D = $SpringArm3D/Camera3D
var dir: Vector3 = Vector3.ZERO
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * 0.4))
		neck.rotate_x(deg_to_rad(-event.relative.y * 0.4))
		neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(-45), deg_to_rad(45))
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_front", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed := Vector3(velocity.x,0,velocity.z)
	dir = dir.move_toward(direction,10.0*delta)
	if dir:

		
		velocity.x = move_toward(velocity.x,dir.x * SPEED, 20.0 * delta) 


		velocity.z = move_toward(velocity.z,dir.z * SPEED, 20.0 * delta)
		
	else:
		velocity.x = move_toward(velocity.x, 0, 1.0 * delta)
		velocity.z = move_toward(velocity.z, 0, 1.0 * delta)
	if speed.length():
		temp = delta * speed.length()
		ball.global_rotate(Vector3.UP.cross(speed.normalized()),temp / radius)
	move_and_slide()
