class AddAvailableToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :available, :boolean, :default => true
  end
end
