require 'json'
require 'open-uri'

class Itune
  attr_accessor :search_hash, :url, :user, :all_movies

  BASE_URL = "https://itunes.apple.com/search?entity=movie&term="

  def initialize(movie, user)
    @user = user
    @movie = movie
    length_check
  end

  def get_movies
    @search_hash = JSON.load(open(@url))

    @search_hash["results"].collect do |movie| 
      
      result = Movie.find_or_create_by(:title => movie["trackName"])

      if all_user_movies.include?(result) && result.country == nil
        result.users.each do |user|
          UserMailer.movie_notification(user, result).deliver
        end

        result.update(
                     :country => movie["country"],
                     :image => movie["artworkUrl100"],
                     :long_descrip => movie['longDescription'],
                     :collection_price => movie["collectionPrice"].to_s,
                     :available => true
                   )
      else
        result.update(
             :country => movie["country"],
             :image => movie["artworkUrl100"],
             :long_descrip => movie['longDescription'],
             :collection_price => movie["collectionPrice"].to_s
           )
      end
      result
    end
  end

  private

  def all_user_movies
    @all_users = User.includes(:movies)
    
    @all_users.collect do |user|
      user.movies.collect do |movie|
        movie
      end
    end.flatten
  end

  def length_check  
    if @movie.split(" ").length == 1
      @url = "#{BASE_URL}#{@movie.downcase}"
    else
      @movie = @movie.gsub(" ", "+")
      @url = "#{BASE_URL}#{@movie.downcase}"
    end
  end
end