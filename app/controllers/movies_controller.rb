class MoviesController < ApplicationController
  #user's movies index
  def index
    @user = User.find(params[:user_id])
    @movies = Kaminari.paginate_array(@user.movies.reverse).page(params[:page]).per(3)
  end

  #search results from movies
  def list
    @user = current_user
    @movies = Itune.new(params[:movie]).get_movies
    binding.pry
  end

  def create
    @user = User.find(params[:user_id])
    @movie = Movie.find_or_create_by(movie_params)
    @user.movies.push(@movie)
    redirect_to user_movies_path
  end

  def destroy
    @user = User.find(params[:user_id])
    @movie = @user.movies.find(params[:id])
    @movie.destroy
    redirect_to user_movies_path(@user)
  end

  private

  def movie_params
    params.require(:movies).permit(:title, :country, :short_descrip, :long_descrip, :collection_price, :image)
  end
end
