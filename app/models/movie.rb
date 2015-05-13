class Movie < ActiveRecord::Base
  has_many :users, :through => :user_movies
  has_many :user_movies

  def self.available
    self.where(:available => true)
  end

  def self.unavailable
    self.where(:available => false)
  end
end
