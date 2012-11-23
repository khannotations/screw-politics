class MainController < ActionController::Base
  layout "main"

  # Checks for session[:cas_user]; renders splash if not set.
  # Otherwise renders main page, after fetching required data.
  def index 
  end

  def about
  end

  # Gets a list of all the users, minus yourself (for the typeahead)
  # Done as a seperate request to speed up initial page load
  def all
    render :json => User.all_names
  end

end