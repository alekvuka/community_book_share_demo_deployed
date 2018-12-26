class Neighbourhood
  has_many :books
  has_many :readers


  def slug
    name.downcase.tr(' ', '-')
  end

  def self.find_by_slug(slug)
    Song.all.find { |song| song.slug == slug }
  end
end
