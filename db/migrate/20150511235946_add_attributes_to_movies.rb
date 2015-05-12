class AddAttributesToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :title, :string
    add_column :movies, :country, :string
    add_column :movies, :short_descrip, :text
    add_column :movies, :long_descrip, :text
    add_column :movies, :rental_price, :integer
  end
end
