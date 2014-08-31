class SubscribersController < ApplicationController

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.create(email: params[:subscriber][:email])
    if @subscriber.save
      redirect_to root_path, notice: "Thanks for subscribing!"
    else
      render 'form'
    end
  end

end
