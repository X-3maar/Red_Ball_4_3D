extends AnimatableBody3D
@onready var area_3d: Area3D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision := move_and_collide(Vector3.ZERO)
	if collision:
		var collider =collision.get_collider()
		if collider is CharacterBody3D:
			pass
		else:
			area_3d.move_direction = Vector3.ZERO
		
