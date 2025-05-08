class_name ClickerBox extends VBoxContainer

const face: PackedScene = preload("res://face.tscn")

@export var type: Global.ClickerType

@onready var name_text: Label = %ClickerName
@onready var button: Button = %PurchaseButton
@onready var icon_container: Node = %IconContainer


# Engine
func _ready() -> void:
	clear()
	name_text.text = Global.get_clicker_name(type)
	button.text = str(Global.get_cost(type))
	for i in Global.get_count(type):
		add_face()

func _process(_delta: float) -> void:
	@warning_ignore("integer_division")
	if Global.gold_count >= (Global.get_cost(type) / 2):
		visible = true
	button.disabled = Global.gold_count < Global.get_cost(type)


# Public
func clear():
	@warning_ignore("integer_division")
	if Global.gold_count < (Global.get_cost(type) / 2) and Global.get_count(type) == 0:
		visible = false
	button.text = str(Global.get_cost(type))
	# Delete faces
	for child in icon_container.get_children():
		child.queue_free()
	

# Signals
func _on_button_pressed() -> void:
	Global.gold_count -= Global.get_cost(type)
	Global.increment(type)
	button.text = str(Global.get_cost(type))
	add_face()

func add_face() -> void:
	var new_face = face.instantiate()
	new_face.type = type
	icon_container.add_child(new_face)
	
