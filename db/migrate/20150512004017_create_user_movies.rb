class CreateUserMovies < ActiveRecord::Migration
  def change
    create_table :user_movies do |t|
      t.integer :user_id
      t.integer :movie_id
      t.timestamps
    end
    add_index :user_movies, :user_id
    add_index :user_movies, :movie_id
  end
end
