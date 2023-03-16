json.data do 

  json.array!(@games) do |game|
    json.game do

      json.set! "couples" do
        json.array!(@couples.select { |couple| couple.game_id == game.id }) do |couple|
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
        if @workers_without_a_pair.find { |worker| worker.game_id == game.id }
          json.worker @workers_without_a_pair.find { |worker| worker.game_id == game.id }.worker.name
          json.not_play game.year_game
        end
      end
    end
  end

end
