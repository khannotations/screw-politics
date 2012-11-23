class UsersController < ApplicationController
  layout "main"

  def index
    @user = User.find_by_session_id(session[:user])
    @user = User.create_dummy_user if not @user

    # Didn't use @user.screws because there'd be a where clause anyway
    @screws = Screwconnector.includes(:screw).where(screwer_id: @user.id, match_id: 0)
    # a.k.a @user.screwers.includes...where(match_id: 0)
    @screwers = Screwconnector.includes(:screwer).where(screw_id: @user.id, match_id: 0)
    @sent_requests = @user.get_sent
    @got_requests = @user.get_got
    @sent_past = @user.get_past_sent
    @got_past = @user.get_past_got
    @history = @user.history  # not rendered as of now
  end

  # Takes a user's name (e.g. Faiaz "Rafi" Khan), parses out the nickname
  # and renders a json of the user. This is necessary because of how the 
  # typeahead works
  def whois
    me = User.find(session[:user_id])
    if not me or not me.active
      render :json => {:status => "inactive"}
      return
    end
    @user = User.identify(params[:name])
    p = {}
    if @user and @user != me
      p[:name] = @user.fullname
      p[:id] = @user.id
      p[:select] = @user.make_select 
      render :json => {:status => "success", :person => p}
    else # should never happen
      render :json => {:status => "fail", :flash => "No such user >:("}
    end
  end
end
