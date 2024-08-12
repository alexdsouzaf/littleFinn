extends State

@export var run_state : State
@export var idle_state : State


func _on_animated_sprite_2d_animation_finished():
	if parent.animated_sprite_2d.animation == "attack":
		parent.state_machine.change_state(idle_state)
