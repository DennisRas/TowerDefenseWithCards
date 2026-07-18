class_name EnemyTank
extends Enemy

const COLOR := Color(0.25, 0.45, 0.85, 1.0)

static func get_min_level() -> int:
	return 3

static func get_spawn_interval(level: int) -> float:
	return maxf(1.4, 3.5 - (level - 3) * 0.12)

func apply_level(level: int) -> void:
	var t := level - 1
	max_hp *= 1.0 + t * 0.12
	speed *= 1.0 + t * 0.015
	damage *= 1.0 + t * 0.06

func draw_body() -> void:
	var s = radius * 1.6
	draw_rect(Rect2(Vector2(-s * 0.5, -s * 0.5), Vector2(s, s)), COLOR)
