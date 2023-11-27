extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ATENUACAO = 30.0

@onready var animated_sprite_2d = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y += gravity * delta
        if velocity.y > 0:
            animated_sprite_2d.animation = 'fall'

    # Handle Jump.
    if Input.is_action_just_pressed("pular") and is_on_floor():
        velocity.y = JUMP_VELOCITY
        animated_sprite_2d.animation = 'jump'

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction = Input.get_axis("esquerda", "direita")
    if direction:
        velocity.x = direction * SPEED
        if is_on_floor():
            animated_sprite_2d.animation = "running"

        if direction > 0:
            animated_sprite_2d.flip_h = false
        elif direction < 0:
            animated_sprite_2d.flip_h = true
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    # idle animation
    if velocity == Vector2.ZERO and is_on_floor():
        animated_sprite_2d.animation = 'idle'

    move_and_slide()
