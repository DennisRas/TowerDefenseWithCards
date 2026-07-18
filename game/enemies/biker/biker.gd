class_name EnemyBiker
extends Enemy

const COLOR := Color(0.25, 0.75, 0.35, 1.0)

static func get_min_level() -> int:
	return 2

static func get_spawn_interval(level: int) -> float:
	return maxf(0.55, 1.6 - (level - 2) * 0.06)

func apply_level(level: int) -> void:
	var t := level - 1
	max_hp *= 1.0 + t * 0.05
	speed *= 1.0 + t * 0.035
	damage *= 1.0 + t * 0.04

func draw_body() -> void:
	var h = radius * 1.2
	var points = PackedVector2Array([
		Vector2(0, -h),
		Vector2(h * 0.9, h * 0.7),
		Vector2(-h * 0.9, h * 0.7),
	])
	draw_colored_polygon(points, COLOR)
