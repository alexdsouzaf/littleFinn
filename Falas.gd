extends Label

#refatorar para usar um json, para possibilitar o build em outro idioma
var dict_falas : Array[String]

@export var idioma_br : bool = false
@export var idioma_en : bool = false

@export var dict_falas_pt_br : Array[String]
@export var dict_falas_en_us : Array[String]

func _ready():
	if idioma_br:
		dict_falas = dict_falas_pt_br
	elif idioma_en:
		dict_falas = dict_falas_en_us


func _on_timer_falas_timeout():
	var random_index = randf_range(0, len(dict_falas) - 1)
	var fala_selecionada = dict_falas[random_index]
	if fala_selecionada != "":
		%Falas.text = fala_selecionada
		%Falas.visible = true
		%TimerLimparFala.start()


func _on_timer_limpar_fala_timeout():
	%Falas.visible = false
	%Falas.text = ""
	%TimerFalas.start()
