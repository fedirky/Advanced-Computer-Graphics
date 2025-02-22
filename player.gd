extends CharacterBody3D

var SPEED = 6.0
const LERP_AFK_SPEED = 50.0
const JUMP_VELOCITY = 4.5 * 2


func _ready():
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
    # Jumping logic
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_VELOCITY
        return  
    
    # Apply gravity
    if not is_on_floor():
        velocity += 2 * get_gravity() * delta
    
    # Movement direction calculation
    var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
    var camera_direction = $Camera3D.global_transform.basis.z.normalized()
    camera_direction.y = 0
    var camera_right = $Camera3D.global_transform.basis.x.normalized()
    camera_right.y = 0
    var direction = (camera_direction * input_dir.y + camera_right * input_dir.x).normalized()

    if direction:
        velocity.x = direction.x * SPEED
        velocity.z = direction.z * SPEED
        var local_target_rotation = atan2(direction.x, direction.z)
        rotation.y = lerp_angle(rotation.y, local_target_rotation, 0.1)
    else:
        velocity.x = lerp(velocity.x, 0.0, LERP_AFK_SPEED * delta)
        velocity.z = lerp(velocity.z, 0.0, LERP_AFK_SPEED * delta)

    move_and_slide()
