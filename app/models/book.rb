class Book < ActiveRecord::Base
  has_many :reader_books
  belongs_to :community
  has_many :readers, through: :reader_books

  attr_reader :all_ratings

  def initialize(*args)
    super
    @all_ratings = Array.new
  end

  def add_new_rating(rating)
    @all_ratings << rating
    sum = 0.0
    @rating = @all_ratings.map{|rating| sum += rating}[0] / @all_ratings.size.to_f
    @rating
  end

  def slug
    name.downcase.tr(' ', '-')
  end

  def self.find_by_slug(slug)
    Book.all.find { |book| book.slug == slug }
  end
end
