extends CanvasLayer


func _ready() -> void:
	Bgm2.stop()
	if !Bgm1.playing:
		Bgm1.play()
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
