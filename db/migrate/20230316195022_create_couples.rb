class CreateCouples < ActiveRecord::Migration[7.0]
  def change
    create_table :couples do |t|
      t.references :game, null: false, foreign_key: true
      t.references :first_worker, null: false, foreign_key: { to_table: :workers }
      t.references :second_worker, null: false, foreign_key: { to_table: :workers }

      t.timestamps
    end
  end
end
