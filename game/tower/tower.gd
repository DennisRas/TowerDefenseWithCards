extends StaticBody2D

@export var projectile_scene: PackedScene
@export var max_hp := 50

var current_hp: int

signal health_changed(current_hp, max_hp)

@onready var enemies = $"../Enemies"

func _ready() -> void:
	current_hp = max_hp
	queue_redraw()

func add_ability(ability_scene: PackedScene):
	var ability = ability_scene.instantiate()
	$Abilities.add_child(ability)
	
	ability.activate()

#func _on_shoot_timer_timeout():
	#var enemy = get_closest_enemy()
	#
	#if enemy:
		#shoot(enemy)
#
#func get_closest_enemy():
	#var closest = null
	#var distance = INF
#
	#for enemy in enemies.get_children():
		#var d = global_position.distance_to(enemy.global_position)
#
		#if d < distance:
			#distance = d
			#closest = enemy
#
	#return closest
#
#func shoot(enemy):
	#var projectile: Area2D = projectile_scene.instantiate()
#
	#get_parent().get_node("Projectiles").add_child(projectile)
#
	#projectile.global_position = global_position + projectile.direction * 60
	#projectile.z_index = 10
#
	#projectile.direction = (
		#global_position.direction_to(enemy.global_position)
	#)

func take_damage(amount: int):
	current_hp = max(0, current_hp - amount)
	health_changed.emit(current_hp, max_hp)
	print("Tower hit for: ", amount)
	
	if current_hp <= 0:
		destroy()
		
func destroy():
	print("Tower destroyed!")
	queue_free()
	#Game.end()
	get_tree().current_scene.end()

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
