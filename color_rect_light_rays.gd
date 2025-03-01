extends ColorRect

@onready var light: DirectionalLight3D = get_node("../../WorldEnvironment/DirectionalLight3D")
@onready var camera: Camera3D = get_node("../../Player/Camera3D")


func _ready() -> void:
    set_anchors_preset(Control.PRESET_FULL_RECT)

    set_custom_minimum_size(Vector2(0, 0))

    size_flags_horizontal = Control.SIZE_EXPAND_FILL
    size_flags_vertical = Control.SIZE_EXPAND_FILL


func _process(_delta: float) -> void:
    var pos = camera.unproject_position(camera.global_position - (-light.global_basis.z.normalized()))
    material.set_shader_parameter("light_source_pos", pos)
    material.set_shader_parameter("light_source_dir", -light.global_basis.z)
    material.set_shader_parameter("camera_dir", -camera.global_basis.z)
