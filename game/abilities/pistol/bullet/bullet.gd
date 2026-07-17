extends Area2D

@export var speed = 500.0
@export var damage = 0.0
@export var size = 10.0

var direction := Vector2.ZERO

func _ready():
	queue_redraw()
	
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
func _draw() -> void:
	print("DRAW PROJECTILE")
	draw_circle(Vector2.ZERO, size, Color(0.859, 0.541, 0.085, 1.0))

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
