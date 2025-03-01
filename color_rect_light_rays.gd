extends ColorRect

@onready var light: DirectionalLight3D = get_node("../../WorldEnvironment/DirectionalLight3D")
@onready var camera: Camera3D = get_node("../../Player/Camera3D")


func _ready() -> void:
    set_anchors_preset(Control.PRESET_FULL_RECT)


func _process(_delta: float) -> void:
    var pos = camera.unproject_position(camera.global_position - (-light.global_basis.z.normalized()))   
    material.set_shader_parameter("light_source_pos", pos)
    material.set_shader_parameter("light_source_dir", -light.global_basis.z)
    material.set_shader_parameter("camera_dir", -camera.global_basis.z)
