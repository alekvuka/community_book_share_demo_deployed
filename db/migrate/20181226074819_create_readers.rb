class CreateReaders < ActiveRecord::Migration
  def change
    create_table :readers do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :password_digest
      t.integer :community_id
    end
  end
end
