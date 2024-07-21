extends Node

var lng = "es"
var TEXTS = {
	"desc_build_CASTLE_es": "Castillo, genera un recurso de comida y uno de madera por turno, es resistente y tiene buen rango de exploración.",
	"desc_build_HOUSE_es": "Casa, aumenta el limite de guerreros que puedes entrenar.",
	"desc_build_OUTPOST_es": "Avanzada, una torre precaria que permite explorar un amplio rango. Puedes mejorarla a torre defensiva.",
	"desc_build_BARRACK_es": "Cuartel, permite entrenar guerreros que te acompañan.",
	"desc_build_MILICIAN_es": "Milicia, entrena un guerrero que te seguirá y luchará a tu lado. Cada milicia consume uno de comida por turno.",
	"desc_build_TOWER_es": "Torre, dispara a los enemigos cercanos.",
	"desc_build_EXT_FOOD_es": "Extractor, obtiene 2 de comida por turno.",
	"desc_build_EXT_WOOD_es": "Extractor, obtiene 2 de madera por turno.",
	"desc_build_EXT_STONE_es": "Extractor, obtiene 2 de piedra por turno.",
}
# Called when the node enters the scene tree for the first time.
func get_localization(code):
	code+="_"+lng
	if code in TEXTS.keys(): return TEXTS[code]
	else: return code
