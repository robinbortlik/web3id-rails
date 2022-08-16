class HomeController < ApplicationController
  def index
  end

  def logout
    session.clear
    redirect_to root_path
  end
end
