extends Control

@onready var gold_text: Label = %GoldLabel
@onready var rate_text: Label = %RateLabel


# Engine
func _process(_delta: float) -> void:
	rate_text.text = str(Global.rate, "/s")
	gold_text.text = str(int(Global.gold_count))


# Signals
func _on_mine_pressed() -> void:
	Global.gold_count += 1
	gold_text.text = str(Global.gold_count)


func _on_reset_button_pressed() -> void:
	pass # Replace with function body.


func _on_volume_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	pass # Replace with function body.


func _on_clicker_box_button_pressed() -> void:
	pass # Replace with function body.


func _on_clicker_box_2_button_pressed() -> void:
	pass # Replace with function body.


func _on_clicker_box_3_button_pressed() -> void:
	pass # Replace with function body.


func _on_clicker_box_4_button_pressed() -> void:
	pass # Replace with function body.


func _on_clicker_box_5_button_pressed() -> void:
	pass # Replace with function body.
