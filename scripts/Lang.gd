extends Node

var lng = "es"
var TEXTS = {
	"bld_name_RUINS_es": "RUINAS",
	"bld_name_DEBRIS_es": "ESCOMBROS",
	"bld_name_SETTLEMENT_es": "ASENTAMIENTO",
	"bld_name_HOUSE_es": "CASA",
	"bld_name_OUTPOST_es": "AVANZADA",
	"bld_name_BARRACK_es": "CUARTEL",
	"bld_name_MILICIAN_es": "MILICIA",
	"bld_name_TOWER_es": "TORRE",
	"bld_name_EXT_FOOD_es": "RECOLECTOR",
	"bld_name_EXT_WOOD_es": "RECOLECTOR",
	"bld_name_EXT_STONE_es": "RECOLECTOR",
	
	"desc_build_RUINS_es": "Ruinas, estos restos y cimientos pueden utilizarce para edificar nuevas estructuras robustas.",
	"desc_build_SETTLEMENT_es": "Asentamiento, genera un recurso de comida y madera por turno, es resistente y tiene buen rango de exploración.",
	"desc_build_HOUSE_es": "Casa, aumenta el limite de guerreros que puedes entrenar.",
	"desc_build_OUTPOST_es": "Avanzada, una torre precaria que permite explorar un amplio rango. Puedes mejorarla a torre defensiva.",
	"desc_build_BARRACK_es": "Cuartel, permite entrenar guerreros que te acompañan.",
	"desc_build_MILICIAN_es": "Milicia, entrena un guerrero que te seguirá y luchará a tu lado. Cada milicia consume uno de comida por turno.",
	"desc_build_TOWER_es": "Torre, dispara a los enemigos cercanos.",
	"desc_build_EXT_FOOD_es": "Extractor, obtiene 2 de comida por turno.",
	"desc_build_EXT_WOOD_es": "Extractor, obtiene 2 de madera por turno.",
	"desc_build_EXT_STONE_es": "Extractor, obtiene 2 de piedra por turno.",
	
	"tuto_01_es":"Bienvenido a Quiet Lands! \nNecesitamos lo mejor de ti para resolver esta complicada situación. Lo primero será crear un campamento defensivo.",
	"tuto_02_es":"Acercate a una RUINA, allí podrás utilizar los restos para edificar estructuras robustas. \n-Construye un ASENTAMIENTO.",
	"tuto_03_es":"Perfecto! En los escombros mas pequeños podrás construir edificios mas ligeros como avanzadas o pequeñas casas. Ahora debes construir RECOLECTORES para obtener recursos.",
}
# Called when the node enters the scene tree for the first time.
func get_localization(code):
	code+="_"+lng
	if code in TEXTS.keys(): return TEXTS[code]
	else: return code
