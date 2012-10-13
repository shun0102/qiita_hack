class AddNewFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :new_flag, :boolean, :default => true
  end
end
