extends CanvasLayer

@onready var GameOverOverlay = $GameOverOverlay
@onready var Hud = $Hud

func _ready() -> void:
	Gamestate.event.connect(_on_gamestate_event)
	_apply_play_state(Gamestate.play_state)

func _on_gamestate_event(type, data):
	match type:
		Gamestate.Event.STATE_CHANGED:
			_apply_play_state(data.get("state", Gamestate.play_state))
		Gamestate.Event.TOWER_HEALTH_CHANGED:
			Hud.update_tower_health_text(data.current, data.max)

func _apply_play_state(play_state):
	match play_state:
		Gamestate.State.PLAYING:
			Hud.visible = true
			GameOverOverlay.visible = false
		Gamestate.State.GAME_OVER:
			Hud.visible = true
			GameOverOverlay.visible = true
		_:
			Hud.visible = false
			GameOverOverlay.visible = false

func _get_game() -> Node:
	return get_tree().get_first_node_in_group("game")

func _input(event):
	if Gamestate.play_state != Gamestate.State.GAME_OVER:
		return

	if event.is_action_pressed("ui_accept"):
		_get_game().restart()
