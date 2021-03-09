tool
extends Area2D

export var next_scene: PackedScene

# $AnimationPlayer is the short-hand of get_node("AnimationPlayer") 
onready var anim_player: AnimationPlayer = $AnimationPlayer

# show warning message on the hierarchy view if next_scene name property was not set
# this must have the 'tool' key word on line 1
func _get_configuration_warning() -> String:
	return "The next scene property cannot be empty" if not next_scene else ""

func teleport():
	anim_player.play("fade_in")
	
	# sleep, wait for the animation fade in to finish
	# animation_finished is a signal from the AnimationPlayer node
	yield(anim_player, "animation_finished") 
	
	# change scene
	# get tree access the scene tree
	get_tree().change_scene_to(next_scene)

func _on_body_entered(body):
	teleport()
