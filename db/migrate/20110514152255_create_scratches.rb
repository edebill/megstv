class CreateScratches < ActiveRecord::Migration
  def self.up
    create_table :scratches do |t|
      t.integer :user_id
      t.string :body
      t.timestamps
    end

    add_index :scratches, :user_id
  end

  def self.down
    drop_table :scratches
  end
end
