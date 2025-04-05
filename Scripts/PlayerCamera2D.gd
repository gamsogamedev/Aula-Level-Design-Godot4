extends Camera2D

@onready var character_body_2d = $".."
@export var lerp_speed: float = 1.0

func _process(delta: float) -> void:
	pass
	#offset = offset.lerp(character_body_2d.velocity, delta * lerp_speed)
