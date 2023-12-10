class ToppagesController < ApplicationController
  def index
    if logged_in?
      redirect_to errors_url
    end
  end
end
