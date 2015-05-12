class Movie < ActiveRecord::Base
  has_many :users, :through => :user_movies
  has_many :user_movies
end
