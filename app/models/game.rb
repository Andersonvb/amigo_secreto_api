class Game < ApplicationRecord
  validates :year_game, presence: true, uniqueness: true, inclusion: { in: (2023..2032) }
  validate :two_or_more_workers

  has_one :worker_without_a_pair, dependent: :destroy

  has_many :couples, dependent: :destroy

  after_save :create_couples

  private

  def two_or_more_workers
    errors.add(:base, 'Debe haber al menos 2 jugadores para crear un juego') if Worker.count < 2
  end

  def create_couples
    workers = Worker.all.to_a

    # Seleccionamos el empleado que no jugara este año
    if workers.size.odd?
      worker_without_a_pair = select_worker_that_will_not_play(workers)
      workers.delete(worker_without_a_pair)
      create_and_save_worker_without_a_pair(worker_without_a_pair)
    end

    couples = generate_couples(workers)
    create_and_save_couples(couples)
  end

  def select_worker_that_will_not_play(workers)
    worker_without_a_pair = workers.sample

    if Game.exists?(year_game: year_game - 1)
      worker_without_a_pair_last_year = Game.find_by(year_game: year_game - 1).worker_without_a_pair&.worker

      select_worker_that_will_not_play(workers) if worker_without_a_pair == worker_without_a_pair_last_year
    end

    worker_without_a_pair
  end

  def generate_couples(workers)
    couple_combinations = workers.combination(2).to_a

    couples_last_year = couples_to_array(Couple.where(game_id: id - 1).to_a)
    couples_two_years_ago = couples_to_array(Couple.where(game_id: id - 2).to_a)

    possible_couples = couple_combinations - couples_last_year - couples_two_years_ago

    select_couples(possible_couples, workers)
  end

  def select_couples(couple_combinations, workers)
    number_of_couples = workers.size / 2
    possible_set_of_couples = couple_combinations.combination(number_of_couples)

    # Seleccionar el conjunto de parejas en el cual no se repita ningun valor.
    possible_set_of_couples.find do |set_of_couples|
      set_of_couples.flatten.uniq.length == set_of_couples.flatten.length
    end
  end

  def couples_to_array(couples)
    couple_array = []

    couples.each do |couple|
      couple_array << [couple.first_worker, couple.second_worker]
    end

    couple_array
  end

  def create_and_save_couples(couples)
    couples.each do |first_worker, second_worker|
      Couple.create(game_id: id, first_worker_id: first_worker.id, second_worker_id: second_worker.id)
    end
  end

  def create_and_save_worker_without_a_pair(worker_without_a_pair)
    WorkerWithoutAPair.create(game_id: id, worker_id: worker_without_a_pair.id).save
  end
end
