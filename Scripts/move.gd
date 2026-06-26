extends Area3D

var direction = Vector3.ZERO
var dir = Vector3.ZERO
var speed = 0
@onready var animatable_body_3d: AnimatableBody3D = $AnimatableBody3D

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var move = direction * speed * delta
	global_position += move
	
	


func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		dir = Vector3(body.velocity.x,0,body.velocity.z)
		if dir.length():
			direction = dir.normalized()
			speed = body.SPEED 
			
