
module GameAsserts
  def game_response_asserts
    game = Game.find_by_year_game(response_data['year_game'])

    assert game.persisted?
    assert_equal 'application/json; charset=utf-8', response.content_type
    assert response_data.key?('year_game'), 'Game - Year Game'
    assert_equal game.year_game, response_data['year_game'], 'Game - Year Game'
  end
end