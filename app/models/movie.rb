class Movie < ActiveRecord::Base
  has_many :users, :through => :user_movies
  has_many :user_movies

  def self.available
    self.where(:available => true)
  end

  def self.unavailable
    self.where(:available => false)
  end

  def self.unrecognized_movie(movie_title, available)
    self.find_or_create_by(:title => movie_title, :available => available)
  end
end
