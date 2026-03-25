class_name Constants extends Object

const ROCK: String = "Rock"
const PAPER: String = "Paper"
const SCISSORS: String = "Scissors"

const PLAYER_NAME: String = "Player"
const COMPUTER_NAME: String = "Computer"
const TIE_NAME: String = "Tie"

const PLAYER_COLOR: Color = Color.YELLOW
const COMPUTER_COLOR: Color = Color.DARK_RED
const TIE_COLOR: Color = Color.LIGHT_BLUE

static func get_player_color(result: String) -> Color:
	if result == PLAYER_NAME:
		return PLAYER_COLOR
	elif result == COMPUTER_NAME:
		return COMPUTER_COLOR
	elif result == TIE_NAME:
		return TIE_COLOR
	else:
		return Color.WHITE
