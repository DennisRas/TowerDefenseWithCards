class_name AbilityLaser
extends Ability

## Channel visual stats.
@export var beam_width := 5.0
@export var beam_color := Color(0.9, 0.2, 0.15, 0.95)

var tick_timer: Timer
var beam: Line2D

var is_channeling := false
var channel_target: Node2D = null
var channel_time_left := 0.0
var channel_damage_left := 0.0

func _ready() -> void:
	super._ready()

	tick_timer = Timer.new()
	tick_timer.wait_time = TICK_INTERVAL
	tick_timer.timeout.connect(_on_channel_tick)
	add_child(tick_timer)

	beam = Line2D.new()
	beam.width = beam_width
	beam.default_color = beam_color
	beam.visible = false
	beam.z_index = 20
	add_child(beam)

func can_cast() -> bool:
	return not is_channeling

func cast(enemy: Node2D) -> void:
	start_channel(enemy)

func start_channel(enemy: Node2D) -> void:
	is_channeling = true
	channel_target = enemy
	channel_time_left = duration
	channel_damage_left = damage
	beam.visible = true
	_update_beam()
	_on_channel_tick()
	if is_channeling and channel_time_left > 0.0:
		tick_timer.start()

func _process(_delta: float) -> void:
	if not is_channeling:
		return

	if not is_instance_valid(channel_target):
		_try_retarget()
		if not is_channeling:
			return

	_update_beam()

func _on_channel_tick() -> void:
	if not is_channeling:
		return

	if not is_instance_valid(channel_target):
		if not _try_retarget():
			return

	var tick_time = minf(TICK_INTERVAL, channel_time_left)
	var is_final_tick = channel_time_left - tick_time <= 0.001
	var tick_damage: float

	if is_final_tick:
		tick_damage = channel_damage_left
	else:
		tick_damage = minf(get_dps() * tick_time, channel_damage_left)

	if is_instance_valid(channel_target) and tick_damage > 0.0:
		channel_target.take_damage(tick_damage)
		record_damage(tick_damage)
		channel_damage_left = maxf(0.0, channel_damage_left - tick_damage)

	channel_time_left -= tick_time

	if channel_time_left <= 0.001:
		stop_channel()

## Keep using remaining channel time on a new target. Returns false if channel ended.
func _try_retarget() -> bool:
	var tower = get_tower()
	if tower == null:
		stop_channel()
		return false

	var next_target = tower.get_closest_enemy()
	if next_target == null:
		channel_target = null
		beam.visible = false
		return true

	channel_target = next_target
	beam.visible = true
	_update_beam()
	return true

func stop_channel() -> void:
	is_channeling = false
	channel_target = null
	channel_time_left = 0.0
	channel_damage_left = 0.0
	tick_timer.stop()
	beam.visible = false
	start_cooldown()

func _update_beam() -> void:
	if not is_instance_valid(channel_target):
		beam.visible = false
		return

	beam.visible = true
	beam.clear_points()
	beam.add_point(Vector2.ZERO)
	beam.add_point(to_local(channel_target.global_position))
