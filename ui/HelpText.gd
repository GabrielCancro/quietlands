extends Control

func _ready():
	GC.HELPTEXT = self
	unset_text()

func set_text(txcode):
	$Label.text = Lang.get_localization(txcode)
	visible = true

func unset_text():
	visible = false
