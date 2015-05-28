require 'feature_helper'

feature "user functionality" do
  
  context "login functionality" do 
    let!(:user) {create(:user)}

    scenario "redirects back to home page if bad login" do
      visit '/'
      fill_in 'email', :with => user.email
      fill_in 'password', :with => "bananna"
      click_on "Login"
      expect(page).to have_content("Invalid email or password or User does not exist")
    end

    scenario "redirects to the search page when logged in" do
      visit '/'
      fill_in 'email', :with => user.email
      fill_in 'password', :with => user.password
      click_on "Login"
      expect(page).to have_content("Welcome Back #{user.name}")
      expect(page).to have_content('Movie Search') 
    end

    scenario "it can sucessfully log out" do
      visit '/'
      fill_in 'email', :with => user.email
      fill_in 'password', :with => user.password
      click_on "Login"
      click_on "Log out"
      expect(page).to have_content("Signed Out!")
    end
  end

  context "User search functionality" do
    let!(:user) {create(:user)}

    before do
      login(user)
    end

    scenario "search function works" do
      fill_in "movie", :with => "interstellar"
      click_on "Search"
      expect(page).to have_content("Interstellar") 
    end

    scenario "returns no search message found when nothing in database" do
      fill_in "movie", :with => "asdasdadsasd"
      click_on "Search"
      expect(page).to have_content("Nothing matches your search... Would you like to be notified when your movie is available? Subscribe to email list") 
    end
  end

  context "User subscription functionality" do
    let!(:user) {create(:user)}

    before do
      login(user)
    end

    scenario "Notify user with alert message when applying to email subscription" do
      fill_in "movie", :with => "asdasdadsasd"
      click_on "Search"
      click_on "Subscribe to email list"
      expect(page).to have_content("Thank you!, you will be notified when movie is available!") 
    end


  end

  context "User's movies watchlist functionality" do 
    
    let!(:user) {create(:user)}
    let!(:movie) {create(:movie)}
    let!(:user_movie) {create(:user_movie, :user => user, :movie => movie)}

    before do
      login(user)
    end

    scenario "returns user's movies entered in watchlist page" do
      click_on "Welcome Back #{user.name}"
      expect(page).to have_content("#{movie.title}") 
    end

    scenario "delete watchlist does not display movie in watchlist page" do
      click_on "Welcome Back #{user.name}"
      click_on "Delete Watchlist"
      expect(page).not_to have_content("#{movie.title}")
    end
  end
end