class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :nickname
      t.string :lname
      t.string :nickname
      t.string :picture

      t.integer :party, :default => 0
      t.integer :preference, :default => 0
      t.string :profession, :default => "Citizen of society"

      
      t.timestamps
    end
  end
end
