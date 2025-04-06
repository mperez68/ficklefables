extends Control

const PORTENT_PATH: String = "res://assets/text/portents.txt"
const FULL_TEXT: String = "FULLSCREEN"
const HALF_TEXT: String = "HALF-SCREEN"

@onready var FULL_SCREEN: Vector2i = DisplayServer.screen_get_size() * 0.9
@onready var HALF_SCREEN: Vector2i = Vector2i(FULL_SCREEN.x / 0.9, FULL_SCREEN.y / 3)
@onready var ORIGIN: Vector2 = DisplayServer.window_get_position()

@onready var portent_text: Label = %PortentText
@onready var gold_text: Label = %GoldLabel
@onready var rate_text: Label = %RateLabel
@onready var clicker_boxes: Array[Node] = $ClickerListContainer.get_children()
@onready var audio_popup: Popup = $AudioPopupMenu
@onready var reset_popup: PopupMenu = $ResetPopup
@onready var mine_button: Button = $MineButton
@onready var screen_button: Button = $MenuContainer/PanelContainer/MarginContainer/HBoxContainer/ScreenButton
@onready var scrolls: Container = $ScrollContainer

var portents: Array
var half_screen: bool = false

# Engine
func _ready() -> void:
	var file = FileAccess.open(PORTENT_PATH, FileAccess.READ)
	portents = file.get_as_text().split("\n")
	_on_portent_timer_timeout()

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
	Global.save()
	scrolls.update()

func _on_volume_button_pressed() -> void:
	audio_popup.visible = !audio_popup.visible

func _on_exit_button_pressed() -> void:
	Global.save()
	get_tree().quit()

func _on_popup_button_pressed() -> void:
	audio_popup.visible = false

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), linear_to_db(value))

func _on_portent_timer_timeout() -> void:
	portent_text.text = portents.pick_random()

func _on_screen_button_pressed() -> void:
	if half_screen:
		# Set Full Screen
		screen_button.text = HALF_TEXT
		scrolls.visible = true
		DisplayServer.window_set_position(ORIGIN)
		DisplayServer.window_set_size(FULL_SCREEN)
	else:
		# Set Half Screen
		screen_button.text = FULL_TEXT
		scrolls.visible = false
		DisplayServer.window_set_position(ORIGIN - DisplayServer.screen_get_size() * 0.05)
		DisplayServer.window_set_size(HALF_SCREEN)
	half_screen = !half_screen
