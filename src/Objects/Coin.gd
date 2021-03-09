extends Area2D

# get animation player node on ready (this is a godot exclusive)
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

# get other scene/prefab node
onready var coin_value: Label = get_node("/root/Level01/CoinCanvas/coin-value")

func _on_body_entered(body):
	var value: = int(coin_value.text) + 1 # add 1 to coin
	coin_value.text = str(value) # parse back to string
	anim_player.play("fade_out") # play coin fade out anim
