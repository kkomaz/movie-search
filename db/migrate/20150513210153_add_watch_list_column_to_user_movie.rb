class AddWatchListColumnToUserMovie < ActiveRecord::Migration
  def change
    add_column :user_movies, :watchlist, :boolean, :default => true
  end
end
