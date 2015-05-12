class ChangeRentalPriceToCollectionPriceOnMovies < ActiveRecord::Migration
  def change
    rename_column :movies, :rental_price, :collection_price
  end
end
