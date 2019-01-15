class Book < ActiveRecord::Base
  belongs_to :community
  belongs_to :reader

  def add_new_rating(new_rating)
    self.all_ratings = self.all_ratings + new_rating.to_f
    self.number_of_ratings = self.number_of_ratings + 1.0
    rating = self.all_ratings/self.number_of_ratings
    rating
  end

  def slug
    name.downcase.tr(' ', '-')
  end

  def self.find_by_slug(slug)
    Book.all.find { |book| book.slug == slug }
  end
end
