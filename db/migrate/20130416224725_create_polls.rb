class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :group_id
      t.string :question

      t.timestamps
    end
  end
end
