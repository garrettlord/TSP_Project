class AddNameToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :name, :string
    add_index  :polls, :name
  end
end
