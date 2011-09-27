class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :username
      t.integer :age
      t.datetime :joined_at
      t.integer :group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
