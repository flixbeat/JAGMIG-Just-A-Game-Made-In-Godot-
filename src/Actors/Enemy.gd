extends "res://src/Actors/Actor.gd"

func _ready():
	_velocity.x = -speed.x

func _physics_process(delta):
	# apply gracity
	_velocity.y += gravity * delta
	
	# check if it collides on wall
	if is_on_wall():
		_velocity.x *= -1.0 # reverse direction
		
	# apply movement`	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

# similar to on collision enter, but made/called via "signal"
# this is only called when this kinematic collider collides with another kinematic body
# @param: body - is the other body that enters this collider with a type of Node
func _on_StompDetector_body_entered(body):
	
	# if the player y position is lower than the stomp area, do nothing
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	
	
	
	# disable collider node
	get_node("CollisionShape2D").disabled = true
	
	# delete node
	queue_free()
