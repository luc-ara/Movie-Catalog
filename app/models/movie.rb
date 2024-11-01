class Movie < ApplicationRecord
  enum status: { draft: 0, published: 2}

  has_one_attached :poster

  belongs_to :director
  belongs_to :genre

  validates :title, :release_year, :synopsis, :country, :duration, :director, :genre, presence: true
end
