extends CharacterBody2D

@export var speed := 500.0
@export var damage := 10.0
@export var max_hp := 10.0
@export var xp := 1

var current_hp: float
var target: Node2D = null

func _ready() -> void:
	current_hp = max_hp
	queue_redraw()

func take_damage(amount: float):
	current_hp = max(0, current_hp - amount)

	if current_hp <= 0:
		destroy()

func destroy():
	Gamestate.state.kills += 1
	Gamestate.state.xp += xp
	Gamestate.dispatch(Gamestate.Event.ENEMY_KILLED, {
		"kills": Gamestate.state.kills,
		"xp": xp
	})
	queue_free()

func _physics_process(_delta: float) -> void:
	if not is_instance_valid(target):
		return

	var direction := global_position.direction_to(target.global_position)
	velocity = direction * speed
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body.has_method("take_damage"):
			body.take_damage(damage)
			destroy()
			return

func _draw() -> void:
	draw_circle(Vector2.ZERO, 20, Color(0.867, 0.345, 0.188, 1.0))
