class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy update_photo]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_current_user_event, only: [:edit, :update, :destroy]
  before_action :password_guard!, only: [:show]

  def index
    @events = Event.all
  end

  def show
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
  end

  def edit; end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_photo
    event_params = params.require(:event).permit(photos: [])
    event_params[:photos].each do |image|
      @event.photos.attach(image)
      current_user.photos.attach @event.photos.map(&:blob).last
    end
    redirect_to @event, notice: I18n.t('controllers.events.updated')
  end

  def destroy
    @event.destroy
    redirect_to events_url, status: :see_other, notice: I18n.t('controllers.events.destroyed')
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_current_user_event
    @event = current_user.events.find(params[:id])
  end

  def event_params
    params.require(:event)
          .permit(:title, :address, :datetime, :description, :pincode, photos: [])
  end

  def password_guard!
    return true if @event.pincode.blank?
    return true if signed_in? && current_user == @event.user

    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    pincode = cookies.permanent["events_#{@event.id}_pincode"]
    unless @event.pincode_valid?(pincode)
      if params[:pincode].present?
        flash.now[:alert] = I18n.t('controllers.events.wrong_pincode')
      end
      render 'password_form'
    end
  end
end
