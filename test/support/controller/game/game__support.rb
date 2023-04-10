
module GameSupport
  def game_params
    {
      game: {
        year_game: 2025
      }
    }
  end

  def invalid_game_params
    {
      game: {
      year_game: 2021
      }
    }
  end
end