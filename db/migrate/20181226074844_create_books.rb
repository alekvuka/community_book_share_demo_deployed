class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :name
      t.string :description
      t.float :rating
      t.string :comments
    end
  end
end
