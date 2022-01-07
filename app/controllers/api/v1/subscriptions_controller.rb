class Api::V1::SubscriptionsController < ApplicationController
  def index
    render json: SubscriptionSerializer.new(all_subscriptions)
  end

  def create
    sub = Subscription.create!(subscription_params)
    render json: SubscriptionSerializer.new(sub), status: 201
  end

  def update
    sub = Subscription.find(params[:id])
    if valid_update_params?
      sub.update_attribute(:status, 1)
      render json: SubscriptionSerializer.new(sub)
    else
      render json: { error: "Invalid status" }, status: 400
    end
  end

  private

  def all_subscriptions
      Customer.find(params[:customer_id]).subscriptions
  end

  def subscription_params
    params.permit(:title, :price, :status, :frequency, :tea_id, :customer_id)
  end

  def valid_update_params?
    params[:status] == 1 || params[:status] == 'cancelled'
  end
end
