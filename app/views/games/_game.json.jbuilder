couples = Couple.where(game_id: game.id)
worker_without_a_pair = WorkerWithoutAPair.find_by(game_id: game.id)

json.data do
  json.year_game game.year_game
  json.worker_without_play do
    if worker_without_a_pair
      json.id worker_without_a_pair.worker.id
      json.name worker_without_a_pair.worker.name
      json.location worker_without_a_pair.worker.location.name
    end
  end
  json.set! "all_games" do
    json.array! couples do |couple|
      json.game do
        json.set! "couple_#{couple.id}" do
          json.first_player_name couple.first_worker.name
          json.first_player_id couple.first_worker.id
          json.second_player_name couple.second_worker.name
          json.second_player_id couple.second_worker.id
        end
      end
    end
  end
end
