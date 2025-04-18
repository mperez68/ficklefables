class_name ClickerBox extends VBoxContainer

@export var type: Global.ClickerType

@onready var name_text: Label = %ClickerName
@onready var button: Button = %PurchaseButton
@onready var icon_container: CenterContainer = %IconContainer


# Engine
func _ready() -> void:
	clear()
	name_text.text = Global.get_clicker_name(type)
	button.text = str(Global.get_cost(type))

func _process(_delta: float) -> void:
	if Global.gold_count >= (Global.get_cost(type) / 2):
		visible = true
	button.disabled = Global.gold_count < Global.get_cost(type)


# Public
func clear():
	if Global.gold_count < (Global.get_cost(type) / 2) and Global.get_count(type) == 0:
		visible = false
	button.text = str(Global.get_cost(type))
	$HBoxContainer/PanelContainer3/MarginContainer/IconContainer/Label.text = str(Global.get_count(type))	# TODO FickeFables #13
	

# Signals
func _on_button_pressed() -> void:
	Global.gold_count -= Global.get_cost(type)
	Global.increment(type)
	button.text = str(Global.get_cost(type))
	$HBoxContainer/PanelContainer3/MarginContainer/IconContainer/Label.text = str(Global.get_count(type))	# TODO FickeFables #13
