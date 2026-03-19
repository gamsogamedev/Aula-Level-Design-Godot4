extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Se o personagem NÃO estiver no chão, a gravidade o puxa para baixo
	if not is_on_floor():
		velocity.y += gravity * delta

	# Se o personagem pressionar uma tecla de pulo E estiver no chão
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Controla a movimentação lateral
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	UpdateAnimations(direction)
	move_and_slide()

func UpdateAnimations(direction):
	if direction != 0:
		animated_sprite_2d.flip_h = direction < 0
	if is_on_floor():
		if direction != 0:
			animated_sprite_2d.play("running")
		else: 
			animated_sprite_2d.play("idle")
	else:
		if velocity.y > 0:
			animated_sprite_2d.play("fall")
		else:
			animated_sprite_2d.play("jump")
