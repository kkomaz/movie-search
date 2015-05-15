class UserMovie < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  def self.watchlist_status(user, movie)
    (UserMovie.where(:user_id => user.id, :movie_id => movie.id).first.watchlist == true)
  end

  def self.finder(user, movie)
    self.where(:user_id => user.id, :movie_id => movie.id).first
  end
end
