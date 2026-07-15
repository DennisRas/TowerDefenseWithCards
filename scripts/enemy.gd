extends CharacterBody2D

@export var speed := 70.0
@export var damage := 10.0

var target: Node2D = null

func _physics_process(delta: float) -> void:
	if target:
		var direction := global_position.direction_to(target.global_position)
		velocity = direction * speed
		move_and_slide()
		
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var body = collision.get_collider()

			if body.has_method("take_damage"):
				body.take_damage(damage)
				queue_free()
				return

func _draw() -> void:
	draw_circle(Vector2.ZERO, 20, Color(0.867, 0.345, 0.188, 1.0))

func _ready() -> void:
	queue_redraw()
