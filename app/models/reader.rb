class Reader < ActiveRecord::Base
  belongs_to :community
  has_many :books

  has_secure_password

  def slug
    name.downcase.tr(' ', '-')
  end

  def self.find_by_slug(slug)
    Reader.all.find { |reader| reader.slug == slug }
  end
end
