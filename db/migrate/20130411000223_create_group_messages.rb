class CreateGroupMessages < ActiveRecord::Migration
  def change
    create_table :group_messages do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :message

      t.timestamps
    end
  end
end
