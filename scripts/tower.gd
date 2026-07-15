extends StaticBody2D

signal health_changed(current_hp, max_hp)

@export var max_hp := 100
var current_hp: int

func _ready() -> void:
	current_hp = max_hp
	queue_redraw()

func take_damage(amount: int):
	current_hp = max(0, current_hp - amount)
	health_changed.emit(current_hp, max_hp)
	print("Tower hit for: ", amount)
	
	if current_hp <= 0:
		destroy()
		
func destroy():
	print("Tower destroyed!")
	queue_free()
	Game.end()

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
