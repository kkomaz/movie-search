class RemoveShortDescripFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :short_descrip
  end
end
