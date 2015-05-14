class MoviesController < ApplicationController
  #user's movies index
  def index
    @user = User.find(params[:user_id])
    @movies = Kaminari.paginate_array(@user.watchlist).page(params[:page]).per(3)
  end

  #search results from movies
  def list
    @user = current_user
    @movies = Itune.new(params[:movie]).get_movies
    if @movies.empty?
      @movie = Movie.find_or_create_by(:title => params[:movie], 
                                       :available => false)
      @user_movie = UserMovie.find_or_create_by(:user_id => @user.id, :movie_id => @movie.id, :watchlist => false)
    end
  end

  def subscription
    @user = User.find(params[:id])
    @movie = Movie.find_by(:title => params[:movies][:title])
    
    unless @movie.users.include?(@user)
      @movie.users.build(:user => @user)
    end
    redirect_to root_path
  end

  def create
    @user = User.find(params[:user_id])
    @movie = Movie.find_or_create_by(movie_params)
    UserMovie.find_or_create_by(:user_id => @user.id, :movie_id => @movie.id).update(:watchlist => true)
    if !@user.movies.include?(@movie)
      @user.movies.build(:movie => @movie)
    end
    redirect_to user_movies_path
  end

  def destroy
    @user = User.find(params[:user_id])
    @movie = @user.movies.find(params[:id])
    @user_movie = UserMovie.where(:user_id => @user.id, :movie_id => @movie.id)
    @user_movie.first.update(:watchlist => false)
    redirect_to user_movies_path(@user)
  end

  private

  def movie_params
    params.require(:movies).permit(:title, :country, :long_descrip, :collection_price, :image, :available)
  end
end
