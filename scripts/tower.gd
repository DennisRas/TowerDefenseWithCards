extends StaticBody2D

func _ready() -> void:
	queue_redraw()

func _process(delta: float) -> void:
	pass

func _draw() -> void:
	draw_circle(
		Vector2.ZERO,
		40,
		Color(0.189, 0.308, 0.389, 1.0)
	)
	draw_arc(
		Vector2.ZERO,
		40,
		0,
		TAU,
		64,
		Color(0.658, 0.786, 0.808, 1.0),
		3,
		true
	)
