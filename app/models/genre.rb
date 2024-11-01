class Genre < ApplicationRecord
    has_many :movies
    has_many :directors, foreign_key: :favorite_genre_id

    validates :name, presence: true, uniqueness: true
end
