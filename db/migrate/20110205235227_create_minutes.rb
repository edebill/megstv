class CreateMinutes < ActiveRecord::Migration
  def self.up
    create_table :minutes do |t|
      t.integer :user_id
      t.integer :child_id
      t.integer :amount
      t.string  :description

      t.timestamps
    end

    add_index :minutes, :user_id
  end

  def self.down
    drop_table :minutes
  end
end
