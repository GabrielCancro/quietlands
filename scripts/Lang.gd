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
	"bld_name_FOOD_es": "COMIDA",
	"bld_name_WOOD_es": "MADERA",
	"bld_name_STONE_es": "PIEDRA",
	
	"endgame_win_es":"Victoria!",
	"endgame_lose_es":"Has sido derrotado",
	
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
	"tuto_obj_01_es":"- Construye un ASENTAMIENTO.",
	"tuto_03_es":"Perfecto! En los escombros mas pequeños podrás construir edificios mas ligeros como avanzadas o pequeñas casas.",
	"tuto_04_es":"Ahora debes construir RECOLECTORES, para obtener recursos, al comenzar un nuevo día obtendrás los recursos de los recolectores. \n-Construye un RECOLECTOR de MADERA.",
	"tuto_obj_02_es":"- Construye un RECOLECTOR de MADERA.",
	"tuto_04b_es":"Puedes clickear sobre el marcador de días para que el día termine y obtener recursos cuando amanezca nuevamente.",
	
	"tuto_05_es":"Ya casi estamos listos, vas a necesitar algunos soldados para tu campaña. Para reclutar soldados necesitas un CUARTEL, además tienes que tener suficientes casas.",
	"tuto_06_es":"Es importante que sepas que los soldados debes alimentarlos, cada soldado gastará (1) de COMIDA cada día. \n-RECLUTA 2 MILICIAS.",
	"tuto_obj_03_es":"- Construye un CUARTEL y recluta 2 MILICIAS.",
	"tuto_07_es":"Ya tienes lo básico para esta campaña.",
	
	"start_level_2_es":"Utiliza lo que aprendiste para prevalecer. Las noches son peligrosas, asegurate de estar preparado. En las cercanias hay un cristal, debes destruirlo!",
	"map_select_level_es": "La oscuridad espera tu luz. Nivel ",
	"map_select_level_winned_es": "Ya superaste este nivel. ¿Deseas jugarlo nuevamente?",
}
# Called when the node enters the scene tree for the first time.
func get_localization(code):
	code+="_"+lng
	if code in TEXTS.keys(): return TEXTS[code]
	else: return code
