extends CharacterBody2D
class_name JogadorCorpo2D

@onready var animated_sprite_2d = %AnimatedSprite2D
@onready var state_machine = %StateMachine
@onready var polygon_2d : Polygon2D = %Polygon2D

var draggin = false
var mouse_in_area = false
var standby = false;
@export var pet_mode : bool = false

var nova_posicao_passeio : Vector2
#variavel para controlar se o boneco esta fora da tela
#e reposicionar ele
var screen_size : Vector2i
var center_screen_size : Vector2
var offset_re_pos : int = 50

func _ready() -> void:
	state_machine.init(self)
	levelManager.jogador = self
	screen_size = DisplayServer.screen_get_size()
	center_screen_size = (screen_size / 2)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	if pet_mode:
		set_passthrough(%Sprite2D)
	
	if draggin:
		position = get_global_mouse_position()
	
	state_machine.process_frame(delta)

# When called, sets the clickthrough region to the region outside of the sprite
func set_passthrough(sprite: Sprite2D):
	var fator = 1.2
	var texture_center: Vector2 = sprite.texture.get_size() / 2 # Center
	var texture_corners: PackedVector2Array = [
		sprite.global_position + texture_center * Vector2(-1, -1) * fator, # Top left corner
		sprite.global_position + texture_center * Vector2(1, -1) * fator, # Top right corner
		sprite.global_position + texture_center * Vector2(1 , 1) * fator, # Bottom right corner
		sprite.global_position + texture_center * Vector2(-1 ,1) * fator # Bottom left corner
	  ]
	DisplayServer.window_set_mouse_passthrough(texture_corners)


func _on_button_button_down():
	draggin = true
	state_machine.change_state(%draggin)


func _on_button_button_up():
	draggin = false
	state_machine.change_state(%idle)

func _on_button_mouse_entered():
	mouse_in_area = true;

func _on_button_mouse_exited():
	mouse_in_area = false;

func _on_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
				pass
			if event.button_index == MOUSE_BUTTON_MASK_RIGHT && mouse_in_area:
				standby = !standby
				if standby:
					%TimerStandBy.start()
					state_machine.change_state(%idle)

#gera um novo Vector2 para mover o personagem em alguns pixels, para dar o comportamento de "passeando livremente"
func get_random_direction() -> Vector2:
	var new_direction = Vector2(randf_range(-0.5, 0.5),randf_range(-0.5, 0.5)).normalized()
	if is_position_within_bounds(global_position,screen_size) :
		return new_direction
	#se esta fora dos limites volta para uma posicao fixa
	return center_screen_size.normalized()

func is_position_within_bounds(new_position: Vector2, screen_size: Vector2i) -> bool:
	return new_position.x >= 0 and new_position.x < screen_size.x and new_position.y >= 0 and new_position.y < screen_size.y

func get_direction() -> Vector2:
	var mouse_pos = get_global_mouse_position()
	var direction = global_position.direction_to(mouse_pos)
	return direction

func get_distance_between_player_mouse() -> float:
	return global_position.distance_to(get_global_mouse_position()) #calcula a distancia entre duas posicoes globais
	
