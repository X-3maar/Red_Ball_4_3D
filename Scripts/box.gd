extends CharacterBody3D


const SPEED = 10


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("hold") and Global.ins:
		Global.touch = true
	else: Global.touch = false
	if Global.touch:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("move_left", "move_right", "move_front", "move_back")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	Global.ins = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	Global.ins = false
