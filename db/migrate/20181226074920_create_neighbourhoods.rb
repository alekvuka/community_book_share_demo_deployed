class CreateNeighbourhoods < ActiveRecord::Migration
  def change
    create_table :neighbourhoods do |t|
      t.integer :user_id
      t.integer :book_id
    end 
  end
end
