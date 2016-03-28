class EventsController < ApplicationController
  before_action :authenticate_user! , :except => ["index","show"]
  def index
    if params[:search]
      if params[:upcoming] == 'upcoming'
        @events = Event.upcoming_list.upcoming_list_search(params[:search])    
      else
        @events = Event.upcoming_list.upcoming_list_search(params[:search])      
      end
    else
      if params[:upcoming] == 'upcoming'
        @events = Event.upcoming_list 
      else
        if params[:user_id]
          @events = Event.list_event_created_by_curren_user(current_user.id)
        else
          @events = Event.all      
        end
      end
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.build
  end
  def create
    @event = current_user.events.build(event_params)
    @event.save
    if @event
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :extended_html_description, :starts_at, :ends_at, :venue_id ,:hero_image_url, :category_id, :user_id)
  end
end
