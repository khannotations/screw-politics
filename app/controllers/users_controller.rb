class UsersController < ApplicationController
  layout "main"

  def index
    @user = DummyUser.find_by_id(session[:user_id])
    if not @user
      @user = DummyUser.create()
      session[:user_id] = @user.id
    else
      # flash[:success] = "We were able to recover your previous session! All is not lost :)"
    end
    @screws = @user.screwconnectors.includes(:screw).where(match_id: 0)
    @sent_requests = @user.get_sent
    @got_requests = @user.get_got
    @sent_past = @user.get_past_sent
    @got_past = @user.get_past_got
  end

  # Takes a user's name (e.g. Faiaz "Rafi" Khan), parses out the nickname
  # and renders a json of the user. This is necessary because of how the 
  # typeahead works
  def whois
    me = DummyUser.find(session[:user_id])
    if not me
      render :json => {:status => "inactive"}
      return
    end
    @user = User.identify(params[:name])
    p = {}
    if @user
      p[:name] = @user.fullname
      p[:id] = @user.id
      p[:select] = @user.make_select 
      render :json => {:status => "success", :person => p}
    else # should never happen
      render :json => {:status => "fail", :flash => "No such user >:("}
    end
  end
end
