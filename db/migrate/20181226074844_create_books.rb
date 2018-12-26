class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :name
      t.string :description
      t.float :rating
    end
  end
end
