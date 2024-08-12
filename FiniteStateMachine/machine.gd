extends CharacterBody2D
#todo mundo vai extender de CharacterBody2D e essa sera a classe passada para os states
#refatorar para separar os scripts 
@onready var animated_sprite_2d = %AnimatedSprite2D
@onready var state_machine = %StateMachine

@export_category("objetos vivos")
#altera scale.x para a direcao que a maquina deve olhar
@export var facing_right = true;

@export_category("objetos inanimados")
@export var inicio = false
@export var fim = false

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)
	
	if !facing_right:
		scale.x *= -1 
	
	#if is_in_group("jogador"):
		#levelManager.jogador = self

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
