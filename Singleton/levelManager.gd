extends Node
class_name LevelManager

var jogador : JogadorCorpo2D = null

var game_running : bool = false

@export var dock_bottom : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if dock_bottom:
		var screen_size = DisplayServer.screen_get_size()
		# Obtém o tamanho da janela do jogo
		var window_size = get_viewport().get_visible_rect().size

		# Calcula a posição desejada na parte inferior da tela
		var new_position = Vector2(0, (screen_size.y - window_size.y - get_taskbar_height()))
		print(new_position)
		
		# Define a posição da janela
		DisplayServer.window_set_position(new_position)

#calcula a altura da barra de tarefa do windows
func get_taskbar_height():
	return DisplayServer.screen_get_size().y - DisplayServer.screen_get_usable_rect().size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
