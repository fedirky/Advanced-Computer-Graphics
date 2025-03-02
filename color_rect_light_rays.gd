extends ColorRect

@onready var light: DirectionalLight3D = get_node("../../WorldEnvironment/DirectionalLight3D")
@onready var camera: Camera3D = get_node("../../Player/Camera3D")


func _ready() -> void:
    # Встановлюємо ColorRect вручну на 2560x1440
    set_anchors_preset(Control.PRESET_FULL_RECT)
    anchor_left = 0.0
    anchor_right = 0.0
    anchor_top = 0.0
    anchor_bottom = 0.0
    offset_left = 0
    offset_right = 2560  # Ширина
    offset_top = 0
    offset_bottom = 1440  # Висота
    
    # Додаємо тестовий білий фон
    color = Color(1, 1, 1, 1)
    visible = true
    
    print("ColorRect size:", size)  # Перевіряємо правильність розміру

func _process(_delta: float) -> void:
    var pos = camera.unproject_position(camera.global_position - (-light.global_basis.z.normalized()))   
    material.set_shader_parameter("light_source_pos", pos)
    material.set_shader_parameter("light_source_dir", -light.global_basis.z)
    material.set_shader_parameter("camera_dir", -camera.global_basis.z)
