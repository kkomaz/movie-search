class UserMailer < ActionMailer::Base
  default from: "cipherhealthtest@gmail.com"

  def movie_notification(user, movie)
    @user = user
    @movie = movie
    mail(to: @user.email,
         subject: "Your movie is in our database!")
  end
end
