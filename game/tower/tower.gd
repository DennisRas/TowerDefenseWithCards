extends StaticBody2D

@export var max_hp := 50

var current_hp: int

@onready var enemies = $"../Enemies"
@onready var abilities = $Abilities

func _ready() -> void:
	current_hp = max_hp
	queue_redraw()

func reset():
	for child in abilities.get_children():
		child.free()
	current_hp = max_hp
	Gamestate.dispatch(Gamestate.Event.TOWER_HEALTH_CHANGED, {
		"current": current_hp,
		"max": max_hp
	})
	Gamestate.dispatch(Gamestate.Event.ABILITIES_CHANGED)

func add_ability(ability_scene: PackedScene):
	var ability = ability_scene.instantiate()
	abilities.add_child(ability)
	Gamestate.dispatch(Gamestate.Event.ABILITIES_CHANGED)

func get_closest_enemy():
	var closest = null
	var distance = INF

	for enemy in enemies.get_children():
		if not is_instance_valid(enemy):
			continue
		if enemy.has_method("is_targetable") and not enemy.is_targetable():
			continue

		var d = global_position.distance_to(enemy.global_position)

		if d < distance:
			distance = d
			closest = enemy

	return closest

func take_damage(amount: int):
	if current_hp <= 0:
		return

	current_hp = max(0, current_hp - amount)
	Gamestate.dispatch(Gamestate.Event.TOWER_HEALTH_CHANGED, {
		"current": current_hp,
		"max": max_hp
	})

	if current_hp <= 0:
		Gamestate.dispatch(Gamestate.Event.TOWER_DESTROYED)

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
