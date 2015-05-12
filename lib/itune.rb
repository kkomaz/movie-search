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

  def get_json
    @search_hash = JSON.load(open(@url))
  end
end