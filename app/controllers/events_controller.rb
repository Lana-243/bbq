class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  # before_action :authenticate_user!, except: [:show, :index]
  after_action :verify_authorized, only: [:edit, :update, :destroy, :show]

  def index
    @events = Event.all
  end

  def show
    pincode = params[:pincode] || cookies.permanent["events_#{@event.id}_pincode"]

    event_context = EventContext.new(event: @event, pincode: pincode)
    authorize event_context, policy_class: EventPolicy

    cookies.permanent["events_#{@event.id}_pincode"] = pincode

    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  rescue Pundit::NotAuthorizedError
    render_password_form
  end

  def edit; end

  def new
    @event = current_user.events.build

    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)
    authorize @event

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @event

    @event.destroy
    redirect_to events_url, status: :see_other, notice: I18n.t('controllers.events.destroyed')
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event)
          .permit(:title, :address, :datetime, :description, :pincode, :photo)
  end

  def render_password_form
    flash.now[:alert] = I18n.t('controllers.events.wrong_pincode') if params[:pincode].present?
    render 'password_form'
  end
end
