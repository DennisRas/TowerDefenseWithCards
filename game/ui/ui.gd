extends CanvasLayer

@onready var GameOverOverlay = $GameOverOverlay
@onready var Hud = $Hud
@onready var CardSelection = $CardSelection
@onready var PauseMenu = $PauseMenu

func _ready() -> void:
	Gamestate.event.connect(_on_gamestate_event)
	apply_play_state(Gamestate.play_state)

func _on_gamestate_event(type, data):
	match type:
		Gamestate.Event.STATE_CHANGED:
			apply_play_state(data.get("state", Gamestate.play_state))

func apply_play_state(play_state):
	match play_state:
		Gamestate.State.SELECTING:
			Hud.visible = true
			GameOverOverlay.visible = false
			CardSelection.visible = true
		Gamestate.State.PLAYING:
			Hud.visible = true
			GameOverOverlay.visible = false
			CardSelection.hide_choices()
		Gamestate.State.GAME_OVER:
			Hud.visible = true
			GameOverOverlay.visible = true
			CardSelection.hide_choices()
			PauseMenu.close()
		_:
			Hud.visible = false
			GameOverOverlay.visible = false
			CardSelection.hide_choices()
			PauseMenu.close()

func _input(event):
	if Gamestate.play_state != Gamestate.State.GAME_OVER:
		return

	if event.is_action_pressed("ui_accept"):
		Gamestate.dispatch(Gamestate.Event.RESTART_REQUESTED)
