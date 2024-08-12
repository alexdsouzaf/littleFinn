extends State


@export var idle_state : State
@export var attack_state : State

func process_physics(delta: float) -> State:
	var direction : Vector2
	
	if parent.standby:
		direction = parent.nova_posicao_passeio
	else:
		direction = parent.get_direction()
		var distance = parent.get_distance_between_player_mouse()
		
		if distance < 10:
			return idle_state
	
	parent.animated_sprite_2d.flip_h = direction.x < 0
	
	parent.velocity = direction * move_speed 
	parent.move_and_slide()
	
	return null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_area_2d_mouse_entered():
	parent.state_machine.change_state(attack_state)


func _on_timer_stop_passeio_timeout():
	%TimerStandBy.start()
	parent.state_machine.change_state(idle_state)
