class Reader < ActiveRecord::Base
  has_many :reader_books
  belongs_to :community
  has_many :books, through: :reader_books

  has_secure_password

  def slug
    name.downcase.tr(' ', '-')
  end

  def self.find_by_slug(slug)
    Song.all.find { |song| song.slug == slug }
  end
end
