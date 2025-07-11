extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const MAX_JUMPS = 2

var jump_count = 0
var was_on_floor = false

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	# Horizontal movement and sprite flipping
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		player_sprite.flip_h = false
	elif direction < 0:
		player_sprite.flip_h = true

	# Play animation
	if is_on_floor():
		if direction == 0:
			player_sprite.play("idle")
		else:
			player_sprite.play("run")
	else:
		player_sprite.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Reset jump count on landing
	if is_on_floor() and not was_on_floor:
		jump_count = 0
	was_on_floor = is_on_floor()
