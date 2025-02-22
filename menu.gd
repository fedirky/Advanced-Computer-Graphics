extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _on_builtin_volumetric_god_rays_button_down() -> void:
    get_tree().change_scene_to_file("res://built_in_volumetric_god_rays.tscn")


func _on_gdshader_volumetric_god_rays_button_down() -> void:
    pass # Replace with function body.


func _on_exit_button_down() -> void:
    get_tree().quit()
