class ReaderBook < ActiveRecord::Base
  belongs_to :readers
  belongs_to :books
end
