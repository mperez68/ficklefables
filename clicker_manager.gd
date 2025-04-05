extends Control

@onready var gold_text: Label = %GoldLabel
@onready var rate_text: Label = %RateLabel
@onready var clicker_boxes: Array[Node] = $ClickerListContainer.get_children()
@onready var audio_popup: PopupMenu = $AudioPopupMenu
@onready var reset_popup: PopupMenu = $ResetPopup


# Engine
func _process(_delta: float) -> void:
	rate_text.text = str(Global.rate, "/s")
	gold_text.text = str(int(Global.gold_count))


# Signals
func _on_mine_pressed() -> void:
	Global.gold_count += 1
	gold_text.text = str(Global.gold_count)


func _on_reset_button_pressed() -> void:
	reset_popup.visible = !reset_popup.visible


func _on_final_reset_button_pressed() -> void:
	Global.clear()
	for box in clicker_boxes:
		box.clear()
	reset_popup.visible = false


func _on_volume_button_pressed() -> void:
	audio_popup.visible = !audio_popup.visible


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_popup_button_pressed() -> void:
	audio_popup.visible = false


func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), value)
