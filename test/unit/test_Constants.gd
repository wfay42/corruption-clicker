extends GutTest

func test_get_player_color_unknown():
	var result = Constants.get_player_color("Unknown")
	var resultInPlayerColors = result in [Constants.PLAYER_COLOR, Constants.COMPUTER_COLOR, Constants.TIE_COLOR]
	assert_false(resultInPlayerColors, "If given unknown player name, expect to not be given a player color.")
