class MoviesController < ApplicationController
  #user's movies index
  def index
    @user = User.find(params[:user_id])
    @movies = Kaminari.paginate_array(@user.available_movies).page(params[:page]).per(3)
  end

  #search results from movies
  def list
    @user = current_user
    @movies = Itune.new(params[:movie]).get_movies
    if @movies.empty?
      @movie = Movie.find_or_create_by(:title => params[:movie], 
                                       :available => false)
    end
  end

  def subscription
    @user = User.find(params[:id])
    @movie = Movie.find_by(:title => params[:movies][:title])
    
    unless @movie.users.include?(@user)
      @movie.users.push(@user)
    end
    redirect_to root_path
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
    @user.movies.delete(@movie)
    redirect_to user_movies_path(@user)
  end

  private

  def movie_params
    params.require(:movies).permit(:title, :country, :long_descrip, :collection_price, :image, :available)
  end
end
