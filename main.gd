extends Node2D

@export var ativa : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	 # Obtém o tamanho da tela
	if ativa:
		var screen_size = DisplayServer.screen_get_size()
		# Obtém o tamanho da janela do jogo
		var window_size = get_viewport().get_visible_rect().size
		print(screen_size.x)
		print(window_size.x)
		# Calcula a posição desejada na parte inferior da tela
		var new_position = Vector2(0, (screen_size.y - window_size.y - get_taskbar_height()))
		print(new_position)
		
		get_window().size.x = screen_size.x
		# Define a posição da janela
		DisplayServer.window_set_position(new_position)

#calcula a altura da barra de tarefa do windows
func get_taskbar_height():
	return DisplayServer.screen_get_size().y - DisplayServer.screen_get_usable_rect().size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
