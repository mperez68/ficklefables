extends Node

enum ClickerType{ PEASANT, KNIGHT, WIZARD, NOBLE, ROYAL_COURT }
const _CLICKER_BASE_COSTS: Dictionary = {
	ClickerType.PEASANT: 10,
	ClickerType.KNIGHT: 500,
	ClickerType.WIZARD: 3000,
	ClickerType.NOBLE: 25000,
	ClickerType.ROYAL_COURT: 250000
}
const _CLICKER_NAMES: Dictionary = {
	ClickerType.PEASANT: "Peasant",
	ClickerType.KNIGHT: "Knight",
	ClickerType.WIZARD: "Wizard",
	ClickerType.NOBLE: "Noble",
	ClickerType.ROYAL_COURT: "Royalty"
}
const _CLICKER_RATES: Dictionary = {
	ClickerType.PEASANT: 0.1,
	ClickerType.KNIGHT: 0.5,
	ClickerType.WIZARD: 1,
	ClickerType.NOBLE: 5,
	ClickerType.ROYAL_COURT: 10
}
const SAVE_PATH = "user://data.save"
const SETTINGS_PATH = "user://settings.save"
var clicker_counts: Dictionary
var gold_count: float = 0
var rate: float = 0


# Engine
func _ready() -> void:
	# Load Settings
	if FileAccess.file_exists(SETTINGS_PATH):
		var settings = FileAccess.open(SETTINGS_PATH, FileAccess.READ)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), settings.get_var())
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), settings.get_var())
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), settings.get_var())
	# Load game data
	if !FileAccess.file_exists(SAVE_PATH):
		print(Time.get_time_string_from_system() + ": No current save file")
		return
	print(Time.get_time_string_from_system() + ": loading save file")
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	gold_count = file.get_var()
	clicker_counts[ClickerType.PEASANT] = file.get_var()
	clicker_counts[ClickerType.KNIGHT] = file.get_var()
	clicker_counts[ClickerType.WIZARD] = file.get_var()
	clicker_counts[ClickerType.NOBLE] = file.get_var()
	clicker_counts[ClickerType.ROYAL_COURT] = file.get_var()
	update_rate()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save()


# Public
func get_cost(type: ClickerType) -> int:
	return _CLICKER_BASE_COSTS[type] * pow(1.15, get_count(type))

func get_clicker_name(type: ClickerType) -> String:
	return _CLICKER_NAMES[type]

func get_count(type:ClickerType) -> int:
	var count = 0
	if clicker_counts.has(type):
		count = clicker_counts.get(type)
	else:
		clicker_counts.set(type, 0)
	return count

func increment(type: ClickerType):
	if clicker_counts.has(type):
		clicker_counts.set(type, clicker_counts.get(type) + 1)
	else:
		clicker_counts.set(type, 1)
	update_rate()

func update_rate():
	rate = 0
	for type in ClickerType.size():
		rate = rate + (get_count(type) * _CLICKER_RATES[type])

func clear():
	clicker_counts.clear()
	gold_count = 0
	update_rate()

func save() -> void:
	# Settings data
	var settings = FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	settings.store_var(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	settings.store_var(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	settings.store_var(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sfx")))
	# Game data
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	print(Time.get_time_string_from_system() + ": Saving")
	file.store_var(gold_count)
	file.store_var(clicker_counts.get(ClickerType.PEASANT), 0)
	file.store_var(clicker_counts.get(ClickerType.KNIGHT), 0)
	file.store_var(clicker_counts.get(ClickerType.WIZARD), 0)
	file.store_var(clicker_counts.get(ClickerType.NOBLE), 0)
	file.store_var(clicker_counts.get(ClickerType.ROYAL_COURT), 0)


# Private
func _on_gold_timer_timeout() -> void:
	gold_count += rate
