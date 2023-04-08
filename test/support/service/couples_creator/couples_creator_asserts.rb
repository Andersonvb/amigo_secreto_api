module CouplesCreatorAsserts
  def couples_creator_asserts(game)
    couples_created = CouplesCreator.call(game)

    assert_not_nil couples_created
    assert_equal 'Array', couples_created.class.to_s, 'Correct type'
    assert_equal (Worker.all.size / 2).floor, couples_created.size, 'Correct number of couples'
    
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