class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def list
    @user = current_user
    @movies = Itune.new(params[:movie]).get_json["results"]
  end

  def create
    @user = User.find(params[:user_id])
    @movie = Movie.find_or_create_by(movie_params)
    if !@user.movies.include?(@movie)
      @user.movies << @movie
      redirect_to user_movies_path
    else
      render 'movies'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to user_movies_path(@user)
  end

  private

  def movie_params
    params.require(:movies).permit(:title, :country, :short_descrip, :long_descrip, :rental_price, :image)
  end
end