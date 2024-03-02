extends CharacterBody2D

class_name Player

const SPEED = 500.0
const ACCELERATION = 2400.0
const FRICTION = 3000.0
const JUMP_VELOCITY = -800.0
const GRAVITY = 1200

var was_on_floor : bool = false
var can_jump : bool = false

var frozen : bool = false

func _ready():
	frozen = false

func _process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if was_on_floor:
			was_on_floor = false
			$CoyoteTimer.start(0.15)
	else:
		can_jump = true

	if Input.is_action_just_pressed("ui_accept") and can_jump:
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	if !frozen: move_and_slide()
	
	if is_on_floor():
		was_on_floor = true

func _on_coyote_timer_timeout():
	can_jump = false
