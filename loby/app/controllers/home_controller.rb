class HomeController < ApplicationController
  def index
    render :index, layout: 'fullpage'
  end
end
