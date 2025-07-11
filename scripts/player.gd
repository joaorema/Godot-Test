extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -250.0
const MAX_JUMPS = 2
const dash_speed = 300.0

var dash_time = 0.3   # seconds
var dash_timer = 0.0
var jump_count = 0
var was_on_floor = false
var dashing = false

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

	if Input.is_action_just_pressed("dash") and not dashing:
		dashing = true
		dash_timer = dash_time
		player_sprite.play("dash")
		
		
		
	# Play animation
	if not dashing:
		if is_on_floor():
			if direction == 0:
				player_sprite.play("idle")
			else:
				player_sprite.play("run")
		else:
			player_sprite.play("jump")

	# Apply movement
	if dashing:
		dash_timer -= delta
		var dash_direction = sign(velocity.x)
		if dash_direction == 0:
			dash_direction = -1 if player_sprite.flip_h else 1
		velocity.x = dash_direction * dash_speed

		if dash_timer <= 0:
			dashing = false
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	if dash_timer <= 0:
		dashing = false
	move_and_slide()

	# Reset jump count on landing
	if is_on_floor() and not was_on_floor:
		jump_count = 0
	was_on_floor = is_on_floor()
