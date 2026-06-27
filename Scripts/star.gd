extends Area3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var audio_stream_player_3d_2: AudioStreamPlayer = $AudioStreamPlayer
func _on_body_entered(body: Node3D) -> void:
	Global.score += 1
	collision_shape_3d.queue_free()
	animation_player.play("fade")
	audio_stream_player_3d_2.play()
	await animation_player.animation_finished
	
	queue_free()
