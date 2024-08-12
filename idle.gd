extends State

@export var run_state : State
@export var attack_state : State


func process_physics(delta: float) -> State:
	var direction = parent.get_direction()
	parent.animated_sprite_2d.flip_h = direction.x < 0
	return null


func _on_area_2d_mouse_exited():
	if !parent.standby: # se esta em standby , nao permite sair do idle state a nao ser que seja pelo timer
		parent.state_machine.change_state(run_state)


func _on_timer_timeout():
	parent.state_machine.change_state(run_state)

#timer que inicia quando o boneco entra em standby e faz ele comçar a passear to timeout
func _on_timer_stand_by_timeout():
	if parent.standby:
		parent.nova_posicao_passeio = parent.get_random_direction()
		%TimerStopPasseio.start()
		parent.state_machine.change_state(run_state)
