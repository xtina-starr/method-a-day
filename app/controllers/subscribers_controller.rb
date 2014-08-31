class SubscribersController < ApplicationController

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.create(subscriber_params)
    if @subscriber.save
      redirect_to root_path, notice: "Thanks for subscribing!"
    else
      render 'form'
    end
  end

  private
  def subscriber_params
    params.require(:subscriber).permit(:email)
  end

end
