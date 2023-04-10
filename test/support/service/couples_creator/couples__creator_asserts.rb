module CouplesCreatorAsserts
  def couples_creator_asserts(game)
    couples_created = CouplesCreator.call(game)

    assert_not_nil couples_created
    assert_equal 'Array', couples_created.class.to_s, 'Correct type'
    assert_equal (Worker.all.size / 2).floor, couples_created.size, 'Correct number of couples'

    couples_two_years_ago = Couple.where(game_id: Game.find_by(year_game: game.year_game - 2)&.id)
    couples_last_year = Couple.where(game_id: Game.find_by(year_game: game.year_game - 1)&.id)
    couples_current_year = Couple.where(game_id: game.id)
    
    assert_not_equal couples_last_year.sort, couples_current_year.sort 
    assert_not_equal couples_two_years_ago.sort, couples_current_year.sort

    if Worker.all.size.even?
      assert_nil WorkerWithoutAPair.find_by(game_id: game.id)
    else
      assert_not_nil WorkerWithoutAPair.find_by(game_id: game.id)
    end
  end

  def couples_creator_failing_asserts(game)
    assert_nil CouplesCreator.call(game)
    assert_nil Couple.find_by(game_id: game.id)
    assert_nil WorkerWithoutAPair.find_by(game_id: game.id)
  end
end