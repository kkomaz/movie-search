module MoviesHelper
  def watch_list(user, movie)
    if @user.movies.include?(movie) && (UserMovie.where(:user_id => user.id, :movie_id => movie.id).first.watchlist == true)
      link_to 'Delete Watchlist', user_movie_path(@user, movie), confirm: 'Are you sure?', method: :delete, class: "btn btn-danger"
    else
      link_to user_movies_path(@user,
                          {:movies => {
                              :title => movie.title,
                              :country => movie.country,
                              :collection_price => movie.collection_price.to_s,
                              :image => movie.image,
                              :long_descrip => movie.long_descrip
                            }}),
                          class: "btn btn-success",
                          :method => :post do
      "Save to Watchlist"
    end
    end
  end

end
