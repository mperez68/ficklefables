extends VBoxContainer

signal button_pressed

func _on_button_pressed() -> void:
	button_pressed.emit()
