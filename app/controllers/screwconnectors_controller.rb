class ScrewconnectorsController < ApplicationController
  layout "main"
  
  def show
    @user = DummyUser.find(session[:user_id])
    @sc = Screwconnector.includes(:screw, :screwer).where(id: params[:id]).first
    if not @user or not @sc or not @sc.screwer == @user
      flash[:error] = "Sorry, you can't access that url."
      redirect_to :root
      return 
    end

    everything = @sc.find_everything
    @all_screws = everything[0]
    @int_matches = everything[1]        # Matches by similar intensity
    @event_matches = everything[2]      # Matches by same event
    @all_matches = everything[3]        # All users that are matches
    
  end

  def create
    user_id = session[:user_id]
    # Instead of using @user.screws to avoid retrieving user
    count = Screwconnector.where(screwer_id: user_id, match_id: 0).count
    if count >= 10
      render :json => 
        {
          :status => "fail", 
          :flash => "Sorry, you can only screw up to ten people simultaneously. Match one of them first and try again."
        }
      return
    end
    sc = Screwconnector.includes(:screw).where(
      screw_id: params[:screw_id],
      event: params[:event]
      ).first
    if sc
      if sc.screwer_id == user_id
        render :json => 
          {
            :status => "fail", 
            :flash => "You're already screwing #{sc.screw.nickname} for #{sc.event}!"
          }
        return
      end
    end
    event = User.get_event(params[:event])
    sc = Screwconnector.create(
      screw_id: params[:screw_id], 
      screwer_id: user_id, 
      intensity: params[:intensity],
      event: event
    )
    unless sc.errors.messages.empty?
      render :json => {:status => "fail", :flash => sc.errors.messages}
    end
    render :partial => "screwconnectors/main", :locals => {:sc => sc}
  end

  def destroy
    sc = Screwconnector.find(params[:sc_id]).destroy
    if sc
      flash[:success] = "Yeah! You don't need 'em anyway!"
      # email not necessary
      render :json => {:status => "success"} # triggers page reload
    else 
      render :json => {:status => "fail", :flash => "Screw not found..."}
    end
  end

end
