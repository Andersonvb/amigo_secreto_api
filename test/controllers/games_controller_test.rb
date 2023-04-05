require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  include ParsedResponse
  include GameSupport
  include GameAsserts
  
  test 'Index Games' do
    get_games_index

    assert_response :ok
    assert_equal Game.all.size, response_data.size, 'Game - Index'
  end

  test 'Show Games' do
    game = games(:game_one)

    get_game_show(game)

    assert_response :ok
  end

  test 'Create Games' do
    params = game_params

    post_games_create(params)

    assert_response :created
    game_response_asserts
  end

  test 'Invalid Create Games' do
    params = invalid_game_params

    post_games_create(params)

    assert_response :unprocessable_entity
  end

  private

  def get_games_index
    get v1_games_path
  end

  def get_game_show(game)
    get v1_game_path(game)
  end

  def post_games_create(params)
    post v1_games_path, params: params
  end
end
