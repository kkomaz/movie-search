class User < ActiveRecord::Base

  has_many :movies, :through => :user_movies
  has_many :user_movies

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  def authenticate(password)
    return false unless user = super(password)
    user.create_token! if user.auth_token.nil?
    user
  end

  def authenticate_with_token(token)
    return false if token.nil?
    self.auth_token == token ? self : false
  end

  def create_token!
    token = SecureRandom.urlsafe_base64(nil, false)
    update_attribute :auth_token, token
  end
  
  def destroy_token!
    update_attribute :auth_token, nil
  end

  def watchlist
    movie_ids = UserMovie.where(:user_id => self.id, :watchlist => true).pluck(:movie_id)
    Movie.where(:id => movie_ids)
  end

  def available_movies
    self.movies.where(:available => true)
  end

  # def unavailable_movies
  #   self.movies.where(:available => false)
  # end

end
