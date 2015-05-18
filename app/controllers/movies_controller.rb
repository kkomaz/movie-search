class MoviesController < ApplicationController
  before_action :find_user, :only => [:index, :create, :destroy]
  before_action :find_movie, :only => [:subscription, :create]

  #user's movies index
  def index
    @movies = Kaminari.paginate_array(@user.watchlist).page(params[:page]).per(3)
  end

  #search results from movies
  def list
    @user = current_user
    @movies = Itune.new(params[:movie], @user).get_movies
    if @movies.empty?
      @movie = Movie.unrecognized_movie(params[:movie], false)
      @user_movie = UserMovie.find_or_create_by(:user_id => @user.id, :movie_id => @movie.id, :watchlist => false)
    end
  end

  def subscription
    @user = User.find(params[:id])
    unless @movie.users.include?(@user)
      @movie.users.build(:user => @user)
    end
    redirect_to root_path
  end

  def create
    @user_movie = UserMovie.find_or_create_by(:user_id => @user.id, :movie_id => @movie.id)
    @user_movie.update(:watchlist => true)
    
    unless @user.movies.include?(@movie)
      @user.movies.build(:movie => @movie)
    end
  end

  def destroy
    @movie = @user.movies.find(params[:id])
    @user_movie = UserMovie.finder(@user, @movie)
    @user_movie.destroy
    
    respond_to do |format|
      format.html {redirect_to user_movies_path(@user)}
      format.js {}
    end
  end

  private

  def movie_params
    params.require(:movies).permit(:title, :country, :long_descrip, :collection_price, :image, :available)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_movie
    @movie = Movie.find(params[:movies])
  end

end
