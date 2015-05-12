class ChangeCollectionPriceFromIntegerToString < ActiveRecord::Migration
  def change
    change_column :movies, :collection_price, :string
  end
end
