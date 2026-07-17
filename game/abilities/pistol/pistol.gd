class_name AbilityPistol
extends Ability

var bullet = preload("res://game/abilities/pistol/bullet/bullet.tscn")

var damage := 10.0
var cooldown = 1.0

func shoot():
	var bullet_instance = bullet.instantiate()
	bullet_instance.damage = damage
	# Add to projectiles
