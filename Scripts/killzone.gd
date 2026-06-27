extends Area3D

@onready var rb: CharacterBody3D = $"../RB"




func _on_body_entered(body: Node3D) -> void:
	rb.global_position = Global.check 
	
