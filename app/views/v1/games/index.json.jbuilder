json.data do 

  json.array!(@games) do |game|
    json.game do

      json.set! "couples" do
        json.array!(game.couples) do |couple|
          json.set! "couple_#{couple.id}" do
            json.first_player_name couple.first_worker.name
            json.first_player_id couple.first_worker.id
            json.second_player_name couple.second_worker.name
            json.second_player_id couple.second_worker.id
          end
        end
      end

      json.year_game game.year_game

      json.not_play do
        if game.worker_without_a_pair
          json.worker game.worker_without_a_pair.worker.name
          json.not_play game.year_game
        end
      end
    end
  end

end
