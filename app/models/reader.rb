class Reader
  has_many :reader_books
  belongs_to :neighbourhood
  has_many :books, through: :reader_books

  def slug
    name.downcase.tr(' ', '-')
  end

  def self.find_by_slug(slug)
    Song.all.find { |song| song.slug == slug }
  end
end
