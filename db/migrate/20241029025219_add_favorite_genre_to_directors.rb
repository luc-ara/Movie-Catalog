class AddFavoriteGenreToDirectors < ActiveRecord::Migration[7.2]
  def change
    add_column :directors, :favorite_genre_id, :integer
    add_foreign_key :directors, :genres, column: :favorite_genre_id
  end
end
