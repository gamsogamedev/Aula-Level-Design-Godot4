extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ATENUACAO = 30.0

@onready var animated_sprite_2d = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Se o personagem NÃO estiver no chão, a gravidade o puxa para baixo
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			animated_sprite_2d.animation = 'fall'

	# Se o personagem pressionar uma tecla de pulo E estiver no chão
	if Input.is_action_just_pressed("pular") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.animation = 'jump'

	# Controla a movimentação lateral
	var direction = Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
		
		#Controla a animação de movimento do personagem
		if is_on_floor():
			animated_sprite_2d.animation = "running"
		if direction > 0:
			animated_sprite_2d.flip_h = false
		elif direction < 0:
			animated_sprite_2d.flip_h = true
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animação base do personagem caso ele esteja parado no chão
	if velocity == Vector2.ZERO and is_on_floor():
		animated_sprite_2d.animation = 'idle'

	move_and_slide()
