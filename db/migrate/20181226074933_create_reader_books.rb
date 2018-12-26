class CreateReaderBooks < ActiveRecord::Migration
  def change
    create_table :reader_books do |t|
      t.integer :user_id
      t.integebr :book_id
    end 
  end
end
