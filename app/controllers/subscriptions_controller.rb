class SubscriptionsController < ApplicationController
  def create
    @subscription = Subscription.new(blog_id: params[:blog], user_id: params[:user])
    if @subscription.save
      redirect_to blogs_path, notice: 'Subscription was successfully created.'
    else
      redirect_to blogs_path, notice: "Sorry, can't create a subscription"
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    redirect_to blogs_path, notice: "Subscription was successfully deleted"
  end
end
