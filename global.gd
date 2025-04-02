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

var clicker_counts: Dictionary
var gold_count: float = 0
var rate: float = 0

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

func _on_gold_timer_timeout() -> void:
	gold_count += rate
