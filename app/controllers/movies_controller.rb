class MoviesController < ApplicationController
  def index
    result = Itune.new(params[:movie]).get_json["results"].first
    @movie = Movie.new 
    @movie.title = result["trackName"]
    @movie.country = result["country"]
    @movie.short_descrip = result["shortDescription"]
    @movie.long_descrip = result["longDescription"]
    @movie.rental_price = result["trackHdRentalPrice"]
    @movie.image = result["artworkUrl100"]
    @movie.save
  end
end
