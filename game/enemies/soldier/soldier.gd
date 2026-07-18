class_name EnemySoldier
extends Enemy

const COLOR := Color(0.867, 0.345, 0.188, 1.0)

static func get_min_level() -> int:
	return 1

static func get_spawn_interval(level: int) -> float:
	return maxf(0.45, 1.2 - (level - 1) * 0.05)

func apply_level(level: int) -> void:
	var t := level - 1
	max_hp *= 1.0 + t * 0.08
	speed *= 1.0 + t * 0.02
	damage *= 1.0 + t * 0.05

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, COLOR)
