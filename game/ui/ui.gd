extends CanvasLayer

@onready var GameOverOverlay = $GameOverOverlay
@onready var Hud = $Hud

var game

func _ready() -> void:
	print_tree()

func bind(game_instance):
	print("UI BIND CALLED")
	game = game_instance

	print("tower:", game.tower)
	print("state signal:", game.state_changed)
	
	game.tower.health_changed.connect(on_tower_health_changed)
	game.state_changed.connect(on_game_state_changed)

func on_game_state_changed(state):
	print("UI: Game state changed to: ", state)
	#match state:
		#Game.State.GAME_OVER:
			#GameOverOverlay.Show()
		#Game.State.PLAYING:
			#Hud.show()

func show_game_over():
	pass

func show_card_selection():
	pass

func on_tower_health_changed(current, max):
	Hud.update_tower_health_text(current, max)
