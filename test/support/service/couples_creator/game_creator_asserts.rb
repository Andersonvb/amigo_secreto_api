module GameCreatorAsserts
  def game_creator_asserts(game)
    assert GameCreator.call(game)
    assert game.persisted?
  end

  def game_creator_failing_asserts(game)
    refute GameCreator.call(game)
    refute game.persisted?
  end
end