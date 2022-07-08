class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]

  # POST /subscriptions
  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      redirect_to @subscription, notice: I18n.t('controllers.subscriptions.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /subscriptions/1
  def update
    if @subscription.update(subscription_params)
      redirect_to @subscription, notice: I18n.t('controllers.subscriptions.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /subscriptions/1
  def destroy
    @subscription.destroy
    redirect_to subscriptions_url, notice: I18n.t('controllers.subscriptions.destroyed')
  end

  private

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def subscription_params
      params.fetch(:subscription, {})
    end
end
