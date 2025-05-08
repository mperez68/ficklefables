extends VBoxContainer

const SCROLL_PATHS: Array[String] = [
	"res://assets/text/peasantscrolls.txt",
	"res://assets/text/knightscrolls.txt",
	"res://assets/text/wizardscrolls.txt",
	"res://assets/text/noblescrolls.txt",
	"res://assets/text/noblescrolls.txt"
]

@onready var scrolls: Array = [
	$PanelContainer/MarginContainer/Label,
	$PanelContainer2/MarginContainer/Label,
	$PanelContainer3/MarginContainer/Label,
	$PanelContainer4/MarginContainer/Label,
	$PanelContainer5/MarginContainer/Label
]

@export var selected_type: Global.ClickerType

var scrolls_texts: Dictionary[Global.ClickerType, Array]


# Engine
func _ready() -> void:
	for path in SCROLL_PATHS:
		var file = FileAccess.open(path, FileAccess.READ)
		var lines: Array = file.get_as_text().split("\n")
		var type: Global.ClickerType = lines[0].to_int()
		lines.remove_at(0)
		scrolls_texts.set(type, lines)
	update()
	Global.counts_updated.connect(update)


# Public
func update():
	for i in scrolls.size():
		if Global.get_count(selected_type) >= 10 * (i + 1) and scrolls_texts[selected_type].size() > i:
			scrolls[i].get_parent().get_parent().visible = true
			scrolls[i].text = scrolls_texts[selected_type][i]
		else:
			scrolls[i].get_parent().get_parent().visible = false
			scrolls[i].text = ""


# Signals
func _on_button_pressed(new_type: int) -> void:
	@warning_ignore("int_as_enum_without_cast")
	selected_type = new_type
	update()
