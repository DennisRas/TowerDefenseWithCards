class_name Enemy
extends CharacterBody2D

@export var speed := 70.0
@export var damage := 10.0
@export var max_hp := 10.0
@export var xp := 1
@export var radius := 20.0

var current_hp: float
var target: Node2D = null

## First level this type can appear on.
static func get_min_level() -> int:
	return 1

## Seconds between spawns of this type at the given level.
static func get_spawn_interval(_level: int) -> float:
	return 1.0

## Apply per-type stat scaling for the current level (before entering the tree).
func apply_level(_level: int) -> void:
	pass

func _ready() -> void:
	current_hp = max_hp
	queue_redraw()

func take_damage(amount: float) -> void:
	current_hp = max(0, current_hp - amount)

	if current_hp <= 0:
		destroy()

func destroy() -> void:
	Gamestate.state.kills += 1
	Gamestate.state.xp += xp
	Gamestate.dispatch(Gamestate.Event.ENEMY_KILLED, {
		"kills": Gamestate.state.kills,
		"xp": xp
	})
	queue_free()

func is_targetable() -> bool:
	var size = get_viewport_rect().size
	var inset := 8.0
	var p = global_position
	return (
		p.x >= inset
		and p.y >= inset
		and p.x <= size.x - inset
		and p.y <= size.y - inset
	)

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
