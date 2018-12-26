class Book
  has_many :user_books
  belongs_to :neighbourhood
  has_many :users through :user_books


end
