class_name Ability
extends Node2D

enum Type {
	PROJECTILE,
	CHANNEL
}

## Shared minimum tick size for channel abilities.
const TICK_INTERVAL := 0.1

## Shared combat stats — tune these on each ability scene.
@export var display_name := "Ability"
@export var type: Type = Type.PROJECTILE
@export var damage := 10.0
@export var cooldown := 0.5
## Channel only. Clamped to at least TICK_INTERVAL.
@export var duration := 1.0

var cooldown_timer: Timer
var damage_dealt := 0.0

func get_dps() -> float:
	match type:
		Type.CHANNEL:
			return damage / duration
		Type.PROJECTILE:
			return damage / cooldown
		_:
			return 0.0

## Average damage over a full cast + cooldown cycle.
func get_cycle_dps() -> float:
	match type:
		Type.CHANNEL:
			return damage / (duration + cooldown)
		Type.PROJECTILE:
			return damage / cooldown
		_:
			return 0.0

func get_tower() -> Node:
	# Tower/Abilities/<this>
	return get_parent().get_parent()

func _ready() -> void:
	duration = maxf(duration, TICK_INTERVAL)

	cooldown_timer = Timer.new()
	cooldown_timer.wait_time = cooldown
	cooldown_timer.one_shot = (type == Type.CHANNEL)
	cooldown_timer.autostart = true
	cooldown_timer.timeout.connect(_on_cooldown)
	add_child(cooldown_timer)

func can_cast() -> bool:
	return true

func cast(_enemy: Node2D) -> void:
	pass

func start_cooldown() -> void:
	cooldown_timer.start(cooldown)

func record_damage(amount: float) -> void:
	if amount <= 0.0:
		return
	damage_dealt += amount
	Gamestate.state.damage_dealt += amount

func _on_cooldown() -> void:
	if not can_cast():
		if type == Type.CHANNEL:
			start_cooldown()
		return

	var tower = get_tower()
	if tower == null or tower.current_hp <= 0:
		if type == Type.CHANNEL:
			start_cooldown()
		return

	var enemy = tower.get_closest_enemy()
	if enemy == null:
		if type == Type.CHANNEL:
			start_cooldown()
		return

	cast(enemy)
