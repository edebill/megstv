class AddCurrentMinutesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :current_minutes, :integer
  end

  def self.down
    remove_column :users, :current_minutes
  end
end
