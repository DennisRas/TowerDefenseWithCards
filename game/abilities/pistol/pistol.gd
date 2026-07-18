class_name AbilityPistol
extends Ability

const BULLET = preload("res://game/abilities/pistol/bullet/bullet.tscn")

## Projectile-only stats (pushed onto the bullet when firing).
@export var projectile_speed := 500.0
@export var projectile_size := 5.0

func cast(enemy: Node2D) -> void:
	var tower = get_tower()
	var projectile = BULLET.instantiate()
	projectile.setup(damage, projectile_speed, projectile_size, self)

	tower.get_parent().get_node("Projectiles").add_child(projectile)
	projectile.global_position = tower.global_position
	projectile.z_index = 10
	projectile.direction = tower.global_position.direction_to(enemy.global_position)
