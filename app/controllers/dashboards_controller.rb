class DashboardsController < ApplicationController
  def index
    # @athletes = User.all
    # use pagination in stead (will_paginate-bootstrap gem!)
    @athletes = User.paginate(:page => params[:page])
  end
end
