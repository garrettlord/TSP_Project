class CreateScrambleGames < ActiveRecord::Migration
  def change
    create_table :scramble_games do |t|
      t.integer :score
      t.integer :user_id

      t.timestamps
    end
  end
end
