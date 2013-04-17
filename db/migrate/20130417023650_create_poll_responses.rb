class CreatePollResponses < ActiveRecord::Migration
  def change
    create_table :poll_responses do |t|
      t.integer :poll_id
      t.integer :user_id
      t.string :response

      t.timestamps
    end
  end
end
