class CreateScrambleRounds < ActiveRecord::Migration
  def change
    create_table :scramble_rounds do |t|
      t.string :correctWord
      t.string :scrambledWord
      t.integer :usedHint
      t.integer :roundScore
      t.integer :scramble_game_id

      t.timestamps
    end
  end
end
