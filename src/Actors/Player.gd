extends Actor

export var stomp_impulse =  1000.0

func _physics_process(delta):
	# jump interrupt
	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
	
	var direction = get_direction() # move
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted) # jump
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL) # apply movement

func get_direction() -> Vector2:
	# Input.get_action_strength is similar to Ihput.GetAxis in unity
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength(("move_left"))
	var y_movement = -Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	
	return Vector2(x_movement, y_movement)
	
func calculate_move_velocity( linear_velocity: Vector2,	direction: Vector2, speed: Vector2, is_jump_interrupted: bool) -> Vector2:
	var out = linear_velocity # set velocity as out
	out.x = speed.x * direction.x # apply x speed
	out.y += gravity * get_physics_process_delta_time() # apply gravity
	
	# check if jump button is pressed which has a value of -1 when pressed, 0 if not
	if direction.y == -1.0:
		out.y = speed.y * direction.y # alter spped.y value to apply jump
	
	# check if jump interrepted or the jump button released	
	if is_jump_interrupted:
		out.y = 0.0
	
	# return new velocity
	return out

# this is only called when this node's area2d enter another's node area2d
func _on_EnemyDetector_area_entered(area):
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

# this is only called when this kinematic collider collides with another kinematic body
func _on_EnemyDetector_body_entered(body):
	queue_free() # delete this node
