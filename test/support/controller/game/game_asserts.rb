module GameAsserts
  def game_response_asserts
    game = Game.find_by_year_game(response_data['year_game'])

    assert_equal game.year_game, response_data['year_game'], 'Game - Year Game'
  end
end