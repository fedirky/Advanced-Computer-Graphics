extends Camera3D

# Змінні для контролю камери
var target: CharacterBody3D  # Персонаж (має бути материнською нодою)
var distance: float = 4.0  # Відстань камери до персонажа
var vertical_angle: float = 0.3  # Початковий вертикальний кут (радіани)
var horizontal_angle: float = 0.0  # Початковий горизонтальний кут (радіани)
var rotation_speed: float = 0.005  # Швидкість обертання камери

# Максимальні кути по вертикалі
var max_vertical_angle: float = 1.1  # Максимальний кут (вгору)
var min_vertical_angle: float = -0.2  # Мінімальний кут (вниз)

# Викликається при завантаженні сцени
func _ready() -> void:
    target = get_parent() as CharacterBody3D  # Отримуємо посилання на персонажа
    set_position_around_target()

# Обчислення позиції камери відносно персонажа
func set_position_around_target() -> void:
    if not target:
        return

    # Позиція персонажа + висота огляду
    var target_position = target.global_transform.origin + Vector3(0, 1, 0)

    # Точка, на яку спрямований погляд
    var look_at_position = target_position + Vector3(0, 1, 0)

    # Обчислення зміщення камери
    var offset = Vector3(
        distance * cos(vertical_angle) * sin(horizontal_angle),
        distance * sin(vertical_angle),
        distance * cos(vertical_angle) * cos(horizontal_angle)
    )
    
    global_transform.origin = target_position + offset
    look_at(look_at_position, Vector3.UP)

# Обробка вводу миші
func _input(event) -> void:
    if event is InputEventMouseMotion:
        var mouse_input = event.relative * rotation_speed
        horizontal_angle -= mouse_input.x
        vertical_angle = clamp(vertical_angle + mouse_input.y, min_vertical_angle, max_vertical_angle)

        set_position_around_target()

# Оновлення камери кожен кадр
func _process(delta: float) -> void:
    set_position_around_target()
