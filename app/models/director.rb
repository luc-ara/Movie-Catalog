class Director < ApplicationRecord
  belongs_to :favorite_genre, class_name: 'Genre'
  has_many :movies
  
  validates :name, presence: true, uniqueness: true
  validates :nationality, :birth_date, :favorite_genre, presence:true
end
