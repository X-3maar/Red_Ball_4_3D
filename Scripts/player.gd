extends CharacterBody3D

const radius = 0.5
const SPEED = 5.0
var dis = 0
const JUMP_VELOCITY = 4.5
@onready var neck: SpringArm3D = $SpringArm3D
@onready var ball: Node3D = $Ball

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
	if direction:
		dis = direction * SPEED * delta
		velocity.x = direction.x * SPEED 
		

		velocity.z = direction.z * SPEED
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
