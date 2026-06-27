extends Area3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

@onready var audio_stream_player_3d: AudioStreamPlayer = $AudioStreamPlayer



func _on_body_entered(body: Node3D) -> void:
	Global.check = global_position
	animation_player.play("check")
	audio_stream_player_3d.play()
	collision_shape_3d.queue_free()
