extends Area2D

## Runtime values — configured by the owning ability via setup().
var speed := 500.0
var damage := 0.0
var size := 5.0
var direction := Vector2.ZERO
var source_ability: Ability = null

func setup(
	p_damage: float,
	p_speed: float,
	p_size: float,
	p_source: Ability
) -> void:
	damage = p_damage
	speed = p_speed
	size = p_size
	source_ability = p_source

func _ready():
	queue_redraw()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

	if not is_on_screen():
		queue_free()

func is_on_screen() -> bool:
	var rect = get_viewport_rect()
	var p = global_position
	var m = size
	return (
		p.x >= -m
		and p.y >= -m
		and p.x <= rect.size.x + m
		and p.y <= rect.size.y + m
	)

func _draw() -> void:
	draw_circle(Vector2.ZERO, size, Color(0.859, 0.541, 0.085, 1.0))

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		if source_ability:
			source_ability.record_damage(damage)
		queue_free()
