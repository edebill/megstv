class WelcomeController < ApplicationController


  def index
    redirect_to :controller => :minutes, :action => :index if user_signed_in?
  end

end
