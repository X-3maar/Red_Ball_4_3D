extends RigidBody3D
func _physics_process(delta: float) -> void:
	var input := Input.get_vector("move_left","move_right","move_front","move_back")
	if !input:
		apply_central_impulse(Vector3(input.x,0,input.y).normalized() * 500)
