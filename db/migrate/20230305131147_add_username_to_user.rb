class AddUsernameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :field, :string
  end
end
