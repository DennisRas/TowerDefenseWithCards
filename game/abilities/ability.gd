class_name Ability
extends Node2D

const BULLET = preload("res://game/abilities/pistol/bullet/bullet.tscn")

@export var display_name := "Ability"
@export var damage := 10.0
@export var cooldown := 0.5

var cooldown_timer: Timer

func _ready() -> void:
	cooldown_timer = Timer.new()
	cooldown_timer.wait_time = cooldown
	cooldown_timer.autostart = true
	cooldown_timer.timeout.connect(_on_cooldown)
	add_child(cooldown_timer)

func _on_cooldown() -> void:
	# Tower/Abilities/<this>
	var tower = get_parent().get_parent()
	if tower == null or tower.current_hp <= 0:
		return

	var enemy = tower.get_closest_enemy()
	if enemy == null:
		return

	var projectile: Area2D = BULLET.instantiate()
	projectile.damage = damage
	tower.get_parent().get_node("Projectiles").add_child(projectile)
	projectile.global_position = tower.global_position
	projectile.z_index = 10
	projectile.direction = tower.global_position.direction_to(enemy.global_position)
