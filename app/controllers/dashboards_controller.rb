class DashboardsController < ApplicationController
  def index
    # @athletes = User.all
    # use pagination in stead (will_paginate-bootstrap gem!)
    @athletes = User.paginate(:page => params[:page])
  end

  def search
    @athletes = User.search_by_name(params[:search_name]).paginate(page: params[:page])
  end
end
