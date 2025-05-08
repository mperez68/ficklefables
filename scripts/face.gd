extends TextureRect

const NAMES: Dictionary = {
	Global.ClickerType.PEASANT: [ "Reeve", "Cromwell", "Earl", "Renart", "Maugre", "Jerome", "Sagard", "Jep", "Fulk", "The Pervert." ],
	Global.ClickerType.KNIGHT: [ "Reeve", "Cromwell", "Earl", "Renart", "Maugre", "Jerome", "Sagard", "Jep", "Fulk", "The Pervert." ],
	Global.ClickerType.WIZARD: [ "Reeve", "Cromwell", "Earl", "Renart", "Maugre", "Jerome", "Sagard", "Jep", "Fulk", "The Pervert." ],
	Global.ClickerType.NOBLE: [ "Reeve", "Cromwell", "Earl", "Renart", "Maugre", "Jerome", "Sagard", "Jep", "Fulk", "The Pervert." ],
	Global.ClickerType.ROYAL_COURT: [ "Reeve", "Cromwell", "Earl", "Renart", "Maugre", "Jerome", "Sagard", "Jep", "Fulk", "The Pervert." ]
}

const FACES: Dictionary = {
	Global.ClickerType.PEASANT: "res://assets/graphics/stickguys/peasant.png",
	Global.ClickerType.KNIGHT:"res://assets/graphics/stickguys/knight.png" ,
	Global.ClickerType.WIZARD: "res://assets/graphics/stickguys/wizard.png",
	Global.ClickerType.NOBLE: "res://assets/graphics/stickguys/noble.png",
	Global.ClickerType.ROYAL_COURT: "res://assets/graphics/stickguys/royal.png"
}

@export var face_name: String
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var bg: TextureRect = $TextBackground
@onready var label: Label = $NameLabel
@export var type: Global.ClickerType = Global.ClickerType.PEASANT

func _ready() -> void:
	face_name = NAMES[type].pick_random()
	label.text = face_name
	texture = load(FACES[type])

func _on_mouse_entered() -> void:
	anim.play("focus")
	bg.visible = true
	label.visible = true

func _on_mouse_exited() -> void:
	anim.play("default")
	bg.visible = false
	label.visible = false
