require 'json'
require 'open-uri'

class Itune
  attr_accessor :search_hash, :url, :movie

  BASE_URL = "https://itunes.apple.com/search?entity=movie&term="

  def initialize(movie)
    if movie.split(" ").length == 1
      @url = "#{BASE_URL}#{movie.downcase}"
      @movie = movie
    else
      movie = movie.gsub(" ", "+")
      @url = "#{BASE_URL}#{movie.downcase}"
      @movie = movie
    end
  end

  def get_movies
    @search_hash = JSON.load(open(@url))
    
    @search_hash["results"].collect do |movie| 
      Movie.find_or_create_by(
                               :title => movie["trackName"],
                               :country => movie["country"],
                               :image => movie["artworkUrl100"],
                               :short_descrip => movie["shortDescription"],
                               :long_descrip => movie['longDescription'],
                               :collection_price => movie["collectionPrice"]
                             )                        
    end
  end

end