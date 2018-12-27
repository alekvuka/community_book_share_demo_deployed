class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :name
      t.string :description
      t.float :rating
      t.string :comments
      t.string :owner
      t.integer :community_id
      t.float :all_ratings
      t.float :number_of_ratings
    end
  end
end
