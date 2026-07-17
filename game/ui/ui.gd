extends CanvasLayer

var game

func bind(game_instance):
	game = game_instance
	
	game.tower.health_changed.connect(on_tower_health_changed)
	game.state_changed.connect(on_game_state_changed)

func on_game_state_changed(state):
	match state:
		Game.State.GAME_OVER:
			show_game_over()

func show_game_over():
	pass

func show_card_selection():
	pass

func on_tower_health_changed(current, max):
	$Hud.update_tower_health_text(current, max)
